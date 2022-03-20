import UIKit

class ResultViewController: UIViewController {
    
    var correctAnswers: Int
    var numberOfQuestions: Int
    
    var finishQuizButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        addButtonFunctions()
    }
    
    init(correctAnswers: Int, numberOfQuestions: Int) {
        self.correctAnswers = correctAnswers
        self.numberOfQuestions = numberOfQuestions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        self.view.backgroundColor = SystemDesign.backgroundColor
        self.navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = TitleUILabel(textSize: 25)
        navigationItem.hidesBackButton = true
        
        let titleLabel : UILabel = TitleUILabel(textSize: 45.0)
        titleLabel.text = "Result"
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(250)
            maker.height.equalTo(50)
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(100)
        }
        
        let resultLabel = TitleUILabel(textSize: 100.0)
        resultLabel.text = "\(correctAnswers)/\(numberOfQuestions)"
        self.view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(titleLabel.snp.bottom).offset(100)
        }
        
//        let avgQuizResult = UILabel()
//        avgQuizResult.text = "Average quiz result"
//        avgQuizResult.font = avgQuizResult.font.withSize(15)
//        self.view.addSubview(avgQuizResult)
//        avgQuizResult.snp.makeConstraints { (maker) in
//            maker.centerX.equalToSuperview()
//            maker.top.equalTo(resultLabel.snp.bottom).offset(100)
//        }
        
//        let avgQuizResultNumber = UILabel()
//        avgQuizResultNumber.text = "6.2/7"
//        avgQuizResultNumber.font = avgQuizResultNumber.font.withSize(25)
//        self.view.addSubview(avgQuizResultNumber)
//        avgQuizResultNumber.snp.makeConstraints { (maker) in
//            maker.centerX.equalToSuperview()
//            maker.top.equalTo(avgQuizResult.snp.bottom).offset(30)
//        }
        
        finishQuizButton = CustomUIButton(text: "Finish quiz")
        self.view.addSubview(finishQuizButton)
        finishQuizButton.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-100)
        }
        
    }
    
    func addButtonFunctions() {
        finishQuizButton.addTarget(self, action: #selector(finishQuiz), for: .touchUpInside)
    }
    
    @objc
    func finishQuiz() {
        self.navigationController?.viewControllers = [QuizzesViewController()]
    }
    
}
