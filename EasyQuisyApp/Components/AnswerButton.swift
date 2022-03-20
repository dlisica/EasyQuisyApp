import UIKit

class AnswerButton: UIButton {

    init(text: String) {
        super.init(frame: CGRect())
        
        self.backgroundColor = SystemDesign.quizCellColor
        self.setTitle(text, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = 15
        
        self.snp.makeConstraints { (maker) in
            maker.width.equalTo(300)
            maker.height.equalTo(50)
        }
        
        self.addTarget(self, action: #selector(increaseButtonOpacity), for: .touchUpInside)
        self.addTarget(self, action: #selector(decreaseButtonOpacity), for: .touchDown)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func decreaseButtonOpacity(sender: AnyObject) {
        sender.titleLabel?.alpha = 0.3
    }
    
    @objc
    private func increaseButtonOpacity(sender: AnyObject) {
        sender.titleLabel?.alpha = 1.0
    }

    
}
