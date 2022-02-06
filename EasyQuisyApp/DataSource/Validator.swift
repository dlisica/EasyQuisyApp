import Foundation

class Validator {
    
    static func validateEmailAdress(emailAdress: String) -> Status {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: emailAdress) {
            return .success
        } else {
            return .error("E-mail adress is not valid.")
        }
    }
    
    static func validateUsername(username: String) -> Status {
        if username.count < 3 {
            return .error("Username must be at least 3 characters long.")
        } else if username.count > 15 {
            return .error("Username must be at maximal 15 characters long.")
        } else {
            return .success
        }
    }
    
    static func validatePassword(password: String) -> Status {
        if password.count >= 8 {
            return .success
        } else {
            return .error("Password must be at least 8 characters long.")
        }
    }
    
}
