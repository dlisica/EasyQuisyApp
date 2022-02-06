import Foundation

class ChangePasswordPresenter {
    
    private let dataService : DataService
    weak private var changePasswordViewDelegate : ChangePasswordViewDelegate?
        
    init(dataService : DataService){
        self.dataService = dataService
    }
    
    func setViewDelegate(changePasswordViewDelegate : ChangePasswordViewDelegate?){
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
        
        let status = dataService.changePassword(oldPassword: oldPassword, newPassword: newPassword)
        
        if case Status.success = status {
            changePasswordViewDelegate?.returnToSettingsScreen()
        } else {
            changePasswordViewDelegate?.showErrorLabel(text: status.getMessage()!)
        }
    }
    
}
