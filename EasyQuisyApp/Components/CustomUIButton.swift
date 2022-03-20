import UIKit

class CustomUIButton: UIButton {

    init(text: String) {
        super.init(frame: CGRect())
        
        self.backgroundColor = .systemGray4
        self.setTitle(text, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1
        
        self.snp.makeConstraints { (maker) in
            maker.width.equalTo(250)
            maker.height.equalTo(50)
        }
        
        self.addTarget(self, action: #selector(increaseButtonOpacity), for: .touchUpInside)
        self.addTarget(self, action: #selector(decreaseButtonOpacity), for: .touchDown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enable() {
        self.alpha = 1
        self.isEnabled = true
    }
    
    func disable() {
        self.alpha = 0.7
        self.isEnabled = false
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
