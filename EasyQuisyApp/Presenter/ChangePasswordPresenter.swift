import Foundation

class ChangePasswordPresenter {
    
    weak private var changePasswordViewDelegate: ChangePasswordViewDelegate?
    
    func setViewDelegate(changePasswordViewDelegate: ChangePasswordViewDelegate?){
        self.changePasswordViewDelegate = changePasswordViewDelegate
    }
    
    func checkUserInput(oldPassword : String, newPassword : String, repeatedNewPassword : String) {
        if !oldPassword.isEmpty && !newPassword.isEmpty && !repeatedNewPassword.isEmpty {
            changePasswordViewDelegate?.enableSubmitButton()
            changePasswordViewDelegate?.hideErrorLabel()
        } else {
            changePasswordViewDelegate?.disableSubmitButton()
        }
    }
    
    func submitChanges(oldPassword: String, newPassword: String, repeatedNewPassword: String) {
        var errorText : String = ""
        
        if newPassword != repeatedNewPassword {
            errorText = "Passwords do not match."
        } else if oldPassword == newPassword {
            errorText = "New password cannot be same as old."
        }
        
        if !errorText.isEmpty {
            changePasswordViewDelegate?.showErrorLabel(text: errorText)
            return
        }
        
        let status = Validator.validatePassword(password: newPassword)
        if case Status.error(let message) = status {
            changePasswordViewDelegate?.showErrorLabel(text: message)
            return
        }
        
        NetworkService.changePassword(playerId: DataService.getDataService().currentPlayer.id, oldPassword: oldPassword, newPassword: newPassword) { (status: Status) in
            if case Status.success = status {
                self.changePasswordViewDelegate?.returnToSettingsScreen()
            } else {
                self.changePasswordViewDelegate?.showErrorLabel(text: "Network error occured. Please try again.")
            }
        }
      
    }
    
}
