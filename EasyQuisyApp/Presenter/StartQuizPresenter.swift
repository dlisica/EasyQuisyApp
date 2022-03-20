import Foundation

class StartQuizPresenter {
   
    private let dataService : DataService
    weak private var startQuizViewDelegate : StartQuizViewDelegate?
    
    var quiz: Quiz!
        
    init(dataService : DataService, quiz: Quiz) {
        self.dataService = dataService
        self.quiz = quiz
    }
    
    func setViewDelegate(startQuizViewDelegate : StartQuizViewDelegate?){
        self.startQuizViewDelegate = startQuizViewDelegate
    }
    
}
