import Foundation

class QuizzesPresenter {
    
    weak private var quizzesViewDelegate: QuizzesViewDelegate?
    
    private var quizzes = [Quiz]() {
        didSet {
            setCategories()
            quizzesViewDelegate?.updateUI()
        }
    }
    
    private var categories = [QuizCategory]()
        
    init() {
        getQuizzes()
    }
    
    private func getQuizzes() {
        NetworkService.fetchQuizzes() { (quizzes: [Quiz]) in
            self.quizzes = quizzes
        }
    }
    
    func setViewDelegate(quizzesViewDelegate: QuizzesViewDelegate?){
        self.quizzesViewDelegate = quizzesViewDelegate
    }
    
    func setCategories() {
        var categoriesSet = Set<QuizCategory>()
        quizzes.forEach { categoriesSet.insert($0.category) }
        
        var categoriesArray = Array(categoriesSet)
        categoriesArray.sort { $0.rawValue < $1.rawValue }
        
        categories = categoriesArray
    }
   
    func getNumberOfCategories() -> Int {
        var categories = Set<QuizCategory>()
        quizzes.forEach { categories.insert($0.category) }
        return categories.count
    }
    
    func getCategory(categoryIndex: Int) -> QuizCategory {
        return categories[categoryIndex]
    }
    
    func getNumberOfQuizzesByCategory(categoryIndex: Int) -> Int? {
        let category = categories[categoryIndex]
        return quizzes.filter { $0.category == category }.count
    }
    
    func getQuiz(categoryIndex: Int, quizIndex: Int) -> Quiz {
        return quizzes.filter { $0.category == categories[categoryIndex] } [quizIndex]
    }
    
}
