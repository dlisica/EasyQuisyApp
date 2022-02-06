import Foundation

class LoginPresenter {
    
    private let dataService: DataService
    weak private var loginViewDelegate: LoginViewDelegate?
        
    init(dataService: DataService){
        self.dataService = dataService
    }
    
    func setViewDelegate(loginViewDelegate: LoginViewDelegate?){
        self.loginViewDelegate = loginViewDelegate
    }
    
    func checkInput(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            loginViewDelegate?.disableLoginButton()
        } else {
            loginViewDelegate?.enableLoginButton()
        }
    }
    
    func login(username: String, password: String) {
        let status = dataService.loginPlayer(username: username, password: password)
        
        if case Status.success = status {
            loginViewDelegate?.onSuccesfulLogin()
        } else {
            loginViewDelegate?.showErrorLabel(text: status.getMessage()!)
        }
    }
    
}
