import Foundation

class SignupPresenter {
    
    weak private var signupViewDelegate: SignupViewDelegate?
    
    func setViewDelegate(signupViewDelegate: SignupViewDelegate?){
        self.signupViewDelegate = signupViewDelegate
    }
    
    func checkInput(emailAdress: String, username: String, password: String, repeatedPassword: String) {
        if emailAdress.isEmpty || username.isEmpty || password.isEmpty || repeatedPassword.isEmpty {
            signupViewDelegate?.disableSignupButton()
        } else {
            signupViewDelegate?.enableSignupButton()
        }
    }
    
    func validateEmailAdress(emailAdress: String) -> Bool {
        let status = Validator.validateEmailAdress(emailAdress: emailAdress)
        
        if case Status.error(_) = status {
            signupViewDelegate?.showErrorLabel(text: status.getMessage()!)
            return false
        }
        return true
    }
    
    func validateUsername(username: String) -> Bool {
        let status = Validator.validateUsername(username: username)
        
        if case Status.error(_) = status {
            signupViewDelegate?.showErrorLabel(text: status.getMessage()!)
            return false
        }
        return true
    }
    
    func validatePassword(password: String) -> Bool {
        let status = Validator.validatePassword(password: password)
        
        if case Status.error(_) = status {
            signupViewDelegate?.showErrorLabel(text: status.getMessage()!)
            return false
        }
        return true
    }
    
    func validateRepeatedPassword(password: String, repeatedPassword: String) -> Bool {
        if repeatedPassword != password {
            signupViewDelegate?.showErrorLabel(text: "Passwords do not match.")
        }
        return repeatedPassword == password
    }
    
    func signup(emailAdress: String, username: String, password: String, repeatedPassword: String) {
        if !validateEmailAdress(emailAdress: emailAdress) {
            return
        }
        if !validateUsername(username: username) {
            return
        }
        if !validatePassword(password: password) {
            return
        }
        if !validateRepeatedPassword(password: password, repeatedPassword: repeatedPassword) {
            return
        }
        
        NetworkService.registerPlayer(emailAdress: emailAdress, username: username, password: password) { (status: Status) in
            if case Status.success = status {
                self.signupViewDelegate?.onSuccessfulSignup()
            } else {
                self.signupViewDelegate?.showErrorLabel(text: status.getMessage()!)
            }
        }
        
    }
  
}
