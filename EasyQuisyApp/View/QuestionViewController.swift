//
//  QuestionViewController.swift
//  PopQuizApp
//
//  Created by David Lisica on 21.12.2021.
//

import UIKit

protocol QuestionViewDelegate : NSObjectProtocol {
    func markCorrectAnswer(ofIndex index: Int)
    func markWrongAnswer(ofIndex index: Int)
}

class QuestionViewController: UIViewController, QuestionViewDelegate {
   
    var questionPresenter: QuestionPresenter
    
    var progressBar: ProgressBar!
    var questionLabel: UILabel!
    var answers = [UIButton]()
    var nextQuestionButton: CustomUIButton!
    
    init(quiz: Quiz, questionIndex: Int, previousAnswers: [Bool]) {
        questionPresenter = QuestionPresenter(dataService: DataService.getDataService())
        questionPresenter.setQuizData(quiz: quiz, questionIndex: questionIndex, previousAnswers: previousAnswers)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionPresenter.setViewDelegate(questionViewDelegate: self)
        
        setLayout()
        addButtonFunctions()
    }

    func setLayout() {
        self.view.backgroundColor = SystemDesign.backgroundColor
        self.navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = TitleUILabel(textSize: 25)
        navigationItem.hidesBackButton = true
        
        progressBar = ProgressBar()
        let numOfQuestions = questionPresenter.quiz.questions.count
        let previousAns = questionPresenter.previousAnswers
        progressBar.setProgressBar(withCurrentViewIndex: questionPresenter.questionIndex, withNumberOfViews: numOfQuestions, withPreviousStates: previousAns)
        self.view.addSubview(progressBar)
        progressBar.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(100)
        }
        
        let questionLabel = UILabel()
        questionLabel.text = questionPresenter.currentQuestion().question
        questionLabel.numberOfLines = 3
        questionLabel.textAlignment = .center
        questionLabel.font = questionLabel.font.withSize(20.0)
        
        self.view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(progressBar.snp.bottom).offset(30)
            maker.left.equalToSuperview().offset(20)
            maker.right.equalToSuperview().offset(-20)
            maker.height.equalTo(100)
        }
        
        questionPresenter.currentQuestion().answers.forEach { answers.append(AnswerButton(text: $0)) }
        
        let stack = UIStackView(arrangedSubviews: answers)
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        self.view.addSubview(stack)
        stack.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(questionLabel.snp.bottom).offset(50)
        }
        
        var buttonText = "Next question"
        
        if questionPresenter.isLastQuestion() {
            buttonText = "Show result"
        }
        
        nextQuestionButton = CustomUIButton(text: buttonText)
        nextQuestionButton.disable()
        self.view.addSubview(nextQuestionButton)
        nextQuestionButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-100)
        }
        
    }
    
    func addButtonFunctions() {
        answers.forEach { $0.addTarget(self, action: #selector(answerClicked), for: .touchUpInside)  }
        nextQuestionButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
    }
    
    @objc
    func answerClicked(sender: Any) {
        answers.forEach { $0.isEnabled = false }
        
        let answer = sender as? UIButton
        let ansIndex = answers.firstIndex(of: answer!)
        
        answer!.layer.borderWidth = 1
        questionPresenter.answerClicked(onIndex: ansIndex!)
    }
    
    @objc
    func nextQuestion() {
        var previousAnswers = questionPresenter.previousAnswers
        previousAnswers.append(questionPresenter.answerState)
        
        if questionPresenter.questionIndex == questionPresenter.quiz.questions.count - 1 {
            let result = previousAnswers.filter { $0 == true }.count
            let numOfQuestions = questionPresenter.quiz.questions.count
            
            //added start
            
            questionPresenter.submitQuizResult(playingTime: 11.22, score: Int(Double(result) / Double(numOfQuestions) * 1000))
            
            //added end
            
            let newVC = ResultViewController(correctAnswers: result, numberOfQuestions: numOfQuestions)
            navigationController?.pushViewController(newVC, animated: true)
            return
        }
        
        let newVC = QuestionViewController(quiz: questionPresenter.quiz, questionIndex: questionPresenter.questionIndex + 1, previousAnswers: previousAnswers)
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    func markCorrectAnswer(ofIndex index: Int) {
        answers[index].backgroundColor = .green
        progressBar.setCurrentView(isCorrect: true)
        nextQuestionButton.enable()
    }
    
    func markWrongAnswer(ofIndex index: Int) {
        answers[index].backgroundColor = .red
        progressBar.setCurrentView(isCorrect: false)
        nextQuestionButton.enable()
    }
    
}
