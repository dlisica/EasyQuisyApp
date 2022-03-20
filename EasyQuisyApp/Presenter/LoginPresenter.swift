import Foundation

class LoginPresenter {
    
    weak private var loginViewDelegate: LoginViewDelegate?
    
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
        NetworkService.loginPlayer(username: username, password: password) { (status: Status) in
            if case Status.success = status {
                self.loginViewDelegate?.onSuccesfulLogin()
            } else {
                self.loginViewDelegate?.showErrorLabel(text: "Username or password is wrong!")
            }
        }
    }
    
}
