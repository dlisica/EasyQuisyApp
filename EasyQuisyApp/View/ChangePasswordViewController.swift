import UIKit

protocol ChangePasswordViewDelegate : NSObjectProtocol {
    
    func showErrorLabel(text: String)
    func hideErrorLabel()
    func enableSubmitButton()
    func disableSubmitButton()
    func returnToSettingsScreen()
    
}

class ChangePasswordViewController: UIViewController, ChangePasswordViewDelegate {
    
    private let changePasswordPresenter = ChangePasswordPresenter(dataService: DataService.getDataService())

    private var oldPasswordTextField: UITextField!
    private var newPasswordTextField: UITextField!
    private var repeatNewPasswordTextField: UITextField!
    
    private var errorLabel: UILabel!
    
    private var submitButton: CustomUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changePasswordPresenter.setViewDelegate(changePasswordViewDelegate: self)
        
        setLayout()
        addTextFieldFunctions()
        addButtonFunctions()
    }

    private func setLayout() {
        self.view.backgroundColor = SystemDesign.backgroundColor
        self.navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = TitleUILabel(textSize: 25)
        
        let titleLabel : UILabel = TitleUILabel(textSize: 45.0)
        titleLabel.text = "Change password"
        titleLabel.numberOfLines = 2
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(250)
            maker.height.equalTo(150)
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(100)
        }
        
        oldPasswordTextField = InputUITextField(placeholderText: "Old password")
        oldPasswordTextField.isSecureTextEntry = true
        self.view.addSubview(oldPasswordTextField)
        oldPasswordTextField.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(300)
        }
        
        newPasswordTextField = InputUITextField(placeholderText: "New password")
        newPasswordTextField.isSecureTextEntry = true
        self.view.addSubview(newPasswordTextField)
        newPasswordTextField.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(oldPasswordTextField.snp.bottom).offset(20)
        }
        
        repeatNewPasswordTextField = InputUITextField(placeholderText: "Repeat new password")
        repeatNewPasswordTextField.isSecureTextEntry = true
        self.view.addSubview(repeatNewPasswordTextField)
        repeatNewPasswordTextField.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(newPasswordTextField.snp.bottom).offset(20)
        }
        
        errorLabel = ErrorUILabel(text: "Username or password is wrong!")
        self.view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(repeatNewPasswordTextField.snp.bottom).offset(20)
        }
        
        submitButton = CustomUIButton(text: "Submit")
        submitButton.disable()
        self.view.addSubview(submitButton)
        submitButton.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-100)
        }
    }
    
    private func addTextFieldFunctions() {
        oldPasswordTextField.addTarget(self, action: #selector(inputCheck), for: .editingChanged)
        newPasswordTextField.addTarget(self, action: #selector(inputCheck), for: .editingChanged)
        repeatNewPasswordTextField.addTarget(self, action: #selector(inputCheck), for: .editingChanged)
    }
    
    @objc
    private func inputCheck() {
        let oldPassword = oldPasswordTextField.text!
        let newPassword = newPasswordTextField.text!
        let repeatedNewPassword = repeatNewPasswordTextField.text!
        
        changePasswordPresenter.checkUserInput(oldPassword: oldPassword, newPassword: newPassword, repeatedNewPassword: repeatedNewPassword)
    }
    
    private func addButtonFunctions() {
        submitButton.addTarget(self, action: #selector(submitChanges), for: .touchUpInside)
    }
    
    @objc
    private func submitChanges() {
        let oldPassword = oldPasswordTextField.text!
        let newPassword = newPasswordTextField.text!
        let repeatedNewPassword = repeatNewPasswordTextField.text!
        
        changePasswordPresenter.submitChanges(oldPassword: oldPassword, newPassword: newPassword, repeatedNewPassword: repeatedNewPassword)
    }
    
    func showErrorLabel(text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
    }
    
    func hideErrorLabel() {
        errorLabel.isHidden = true
    }
    
    func enableSubmitButton() {
        submitButton.enable()
    }
    
    func disableSubmitButton() {
        submitButton.disable()
    }
    
    func returnToSettingsScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
