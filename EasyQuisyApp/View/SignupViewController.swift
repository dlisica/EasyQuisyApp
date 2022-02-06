import UIKit

protocol SignupViewDelegate : NSObjectProtocol {
    
    func showErrorLabel(text: String)
    func hideErrorLabel()
    func enableSignupButton()
    func disableSignupButton()
    func onSuccessfulSignup()
    
}

class SignupViewController: UIViewController, SignupViewDelegate {
   
    private let signupPresenter = SignupPresenter(dataService: DataService.getDataService())
    
    private var emailTextField: UITextField!
    private var usernameTextField: UITextField!
    private var passwordTextField: UITextField!
    private var repeatPasswordTextField: UITextField!
    private var errorLabel : UILabel!
    private var submitButton: CustomUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupPresenter.setViewDelegate(signupViewDelegate: self)
        
        setLayout()
        addTextFieldFunctions()
        addButtonFunctions()
    }
    
    private func setLayout() {
        self.view.backgroundColor = SystemDesign.backgroundColor
        navigationItem.titleView = TitleUILabel(textSize: 25)
        
        let titleLabel : UILabel = TitleUILabel(textSize: 45.0)
        titleLabel.text = "Sign Up"
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(250)
            maker.height.equalTo(50)
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(100)
        }
        
        emailTextField = InputUITextField(placeholderText: "E-mail")
        self.view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(titleLabel.snp.bottom).offset(100)
        }
        
        usernameTextField = InputUITextField(placeholderText: "Username")
        self.view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(emailTextField.snp.bottom).offset(20)
        }
        
        passwordTextField = InputUITextField(placeholderText: "Password")
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(usernameTextField.snp.bottom).offset(20)
        }
        
        repeatPasswordTextField = InputUITextField(placeholderText: "Repeat password")
        repeatPasswordTextField.isSecureTextEntry = true
        self.view.addSubview(repeatPasswordTextField)
        repeatPasswordTextField.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
        
        errorLabel = ErrorUILabel(text: "")
        self.view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(repeatPasswordTextField.snp.bottom).offset(20)
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
        emailTextField.addTarget(self, action: #selector(checkInput), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(checkInput), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkInput), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(checkInput), for: .editingChanged)
    }
    
    @objc
    private func checkInput() {
        let emailAdress = emailTextField.text!
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let repeatedPassword = repeatPasswordTextField.text!
        
        signupPresenter.checkInput(emailAdress: emailAdress, username: username, password: password, repeatedPassword: repeatedPassword)
    }
    
    private func addButtonFunctions() {
        submitButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
    }
    
    @objc
    private func signup() {
        let emailAdress = emailTextField.text!
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let repeatedPassword = repeatPasswordTextField.text!
        
        signupPresenter.signup(emailAdress: emailAdress, username: username, password: password, repeatedPassword: repeatedPassword)
    }

    func showErrorLabel(text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
    }
    
    func hideErrorLabel() {
        errorLabel.isHidden = true
    }
    
    func enableSignupButton() {
        submitButton.enable()
    }
    
    func disableSignupButton() {
        submitButton.disable()
    }
    
    func onSuccessfulSignup() {
        self.navigationController?.popViewController(animated: true)
    }

}
