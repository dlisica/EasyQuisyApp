//
//  QuestionPresenter.swift
//  PopQuizApp
//
//  Created by David Lisica on 21.12.2021.
//

import Foundation

class QuestionPresenter {
   
    private let dataService : DataService
    weak private var questionViewDelegate : QuestionViewDelegate?
    
    var quiz: Quiz!
    var questionIndex: Int!
    var previousAnswers = [Bool]()
    
    var answerState = false
        
    init(dataService : DataService) {
        self.dataService = dataService
    }
    
    func setQuizData(quiz: Quiz, questionIndex: Int, previousAnswers: [Bool]) {
        self.quiz = quiz
        self.questionIndex = questionIndex
        self.previousAnswers = previousAnswers
    }
    
    func setViewDelegate(questionViewDelegate : QuestionViewDelegate?){
        self.questionViewDelegate = questionViewDelegate
    }
    
    func currentQuestion() -> Question {
        return quiz.questions[questionIndex]
    }
    
    func isLastQuestion() -> Bool {
        return questionIndex == quiz.questions.count - 1
    }
    
    func answerClicked(onIndex clickedAns: Int) {
        let correctAns = quiz.questions[questionIndex].correctAnswer
        
        if clickedAns == correctAns {
            questionViewDelegate?.markCorrectAnswer(ofIndex: correctAns)
            answerState = true
        } else {
            questionViewDelegate?.markCorrectAnswer(ofIndex: correctAns)
            questionViewDelegate?.markWrongAnswer(ofIndex: clickedAns)
        }
    }
    
    //added
    func submitQuizResult(playingTime: Double, score: Int) {
        dataService.submitQuizResult(playerId: dataService.currentPlayer.id, quizId: quiz.id, playingTime: playingTime, score: score)
    }
    
    
}

