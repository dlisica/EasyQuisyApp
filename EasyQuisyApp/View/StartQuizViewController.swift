//
//  StartQuizViewController.swift
//  PopQuizApp
//
//  Created by David Lisica on 19.12.2021.
//

import UIKit

protocol StartQuizViewDelegate : NSObjectProtocol {
    
}

class StartQuizViewController: UIViewController, StartQuizViewDelegate {
    
    let startQuizPresenter: StartQuizPresenter!
    
    var startQuizButton: UIButton!

    init(quiz: Quiz) {
        self.startQuizPresenter = StartQuizPresenter(dataService: DataService.getDataService(), quiz: quiz)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startQuizPresenter.setViewDelegate(startQuizViewDelegate: self)
        
        setLayout()
        setButtonFunctions()
    }
    
    private func setLayout() {
        self.view.backgroundColor = SystemDesign.backgroundColor
        self.navigationItem.titleView = TitleUILabel(textSize: 25)
        self.navigationController?.navigationBar.tintColor = .black
        
        let quizContainer = UIView()
        quizContainer.backgroundColor = SystemDesign.quizCellColor
        quizContainer.layer.cornerRadius = 15
        self.view.addSubview(quizContainer)
        quizContainer.snp.makeConstraints { (maker) in
            maker.height.equalTo(500)
            maker.width.equalTo(300)
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(150)
        }
        
        let quizNameLabel = UILabel()
        quizNameLabel.text = startQuizPresenter.quiz.name
        quizNameLabel.font = .boldSystemFont(ofSize: 25)
        quizContainer.addSubview(quizNameLabel)
        quizNameLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(30)
        }
        
        let quizDescriptionLabel = UILabel()
        quizDescriptionLabel.text = startQuizPresenter.quiz.description
        quizDescriptionLabel.font = .systemFont(ofSize: 15)
        quizDescriptionLabel.numberOfLines = 3
        quizDescriptionLabel.textAlignment = .center
        quizContainer.addSubview(quizDescriptionLabel)
        quizDescriptionLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(quizNameLabel.snp.bottom).offset(20)
            maker.left.equalToSuperview().offset(30)
            maker.right.equalToSuperview().offset(-30)
        }
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: startQuizPresenter.quiz.imageUrl)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        quizContainer.addSubview(imageView)
        imageView.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
            maker.height.equalTo(200)
            maker.centerX.equalToSuperview()
            maker.top.equalTo(quizDescriptionLabel.snp.bottom).offset(20)
        }
        
        let quizAuthorLabel = UILabel()
        quizAuthorLabel.text = "By " + startQuizPresenter.quiz.author
        quizAuthorLabel.font = .systemFont(ofSize: 15)
        quizAuthorLabel.textAlignment = .center
        quizContainer.addSubview(quizAuthorLabel)
        quizAuthorLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(imageView.snp.bottom).offset(20)
            maker.left.equalToSuperview().offset(30)
            maker.right.equalToSuperview().offset(-30)
        }
        
        startQuizButton = CustomUIButton(text: "Start quiz")
        quizContainer.addSubview(startQuizButton)
        startQuizButton.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-30)
        }
        
    }
    
    func setButtonFunctions() {
        startQuizButton.addTarget(self, action: #selector(startQuiz), for: .touchUpInside)
    }
    
    @objc
    func startQuiz() {
        let firstQuestionVC = QuestionViewController(quiz: startQuizPresenter.quiz, questionIndex: 0, previousAnswers: [Bool]())
        
        self.navigationController?.pushViewController(firstQuestionVC, animated: true)
    }

}
