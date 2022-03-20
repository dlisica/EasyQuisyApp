import UIKit
import SnapKit

protocol LoginViewDelegate: NSObjectProtocol {
    
    func enableLoginButton()
    func disableLoginButton()
    func showErrorLabel(text: String)
    func hideErrorLabel()
    func onSuccesfulLogin()
    
}

class LoginViewController: UIViewController, LoginViewDelegate {
    
    private let loginPresenter = LoginPresenter()
    
    private var usernameTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: CustomUIButton!
    private var errorLabel : UILabel!
    private var signupButton: CustomUIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginPresenter.setViewDelegate(loginViewDelegate: self)
        
        setLayout()
        addButtonFunctions()
        addTextFieldFunctions()
    }
    
    private func setLayout() {
        self.view.backgroundColor = SystemDesign.backgroundColor
        
        let titleLabel : UILabel = TitleUILabel(textSize: 50.0)
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(300)
            maker.height.equalTo(50)
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(100)
        }
        
        usernameTextField = InputUITextField(placeholderText: "Username")
        self.view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(300)
        }
        
        passwordTextField = InputUITextField(placeholderText: "Password")
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(usernameTextField.snp.bottom).offset(20)
        }
        
        loginButton = CustomUIButton(text: "Login")
        loginButton.disable()
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
        
        errorLabel = ErrorUILabel(text: "")
        self.view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(loginButton.snp.bottom).offset(20)
        }
        
        signupButton = CustomUIButton(text: "Signup")
        self.view.addSubview(signupButton)
        signupButton.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-100)
        }
        
    }
    
    private func addButtonFunctions() {
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
    }
    
    @objc
    private func login() {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        loginPresenter.login(username: username, password: password)
    }
    
    @objc
    private func signup() {
        self.navigationController?.pushViewController(SignupViewController(), animated: true)
    }
    
    private func addTextFieldFunctions() {
        usernameTextField.addTarget(self, action: #selector(checkInput), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkInput), for: .editingChanged)
    }
    
    @objc
    private func checkInput() {
        errorLabel.isHidden = true
        
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        loginPresenter.checkInput(username: username, password: password)
    }
    
    func enableLoginButton() {
        loginButton.enable()
    }
    
    func disableLoginButton() {
        loginButton.disable()
    }
    
    func showErrorLabel(text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
    }
    
    func hideErrorLabel() {
        errorLabel.isHidden = true
    }
    
    func onSuccesfulLogin() {
        let leftNavigationController = UINavigationController(rootViewController: QuizzesViewController())
        let rightNavigationController = UINavigationController(rootViewController: SettingsViewController())
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [leftNavigationController, rightNavigationController]
        
        let quizzesImage = UIImage(systemName: "questionmark.circle")
        let quizzesSelectedImage = UIImage(systemName: "questionmark.circle.fill")
        
        let settingsImage = UIImage(systemName: "gearshape")
        let settingsSelectedImage = UIImage(systemName: "gearshape.fill")
        
        leftNavigationController.tabBarItem = UITabBarItem(title: "Quizzes", image: quizzesImage, selectedImage: quizzesSelectedImage)
        rightNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: settingsImage, selectedImage: settingsSelectedImage)
        
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.selectedIndex = 0
        
        self.view.window!.rootViewController = tabBarController
    }
    
}
