import Foundation

class SettingsPresenter {
    
    private let dataService = DataService.getDataService()
    weak private var settingsViewDelegate: SettingsViewDelegate?
    
    func setViewDelegate(settingsViewDelegate: SettingsViewDelegate?){
        self.settingsViewDelegate = settingsViewDelegate
    }
    
    func getCurrentPlayerEmail() -> String {
        return dataService.currentPlayer.emailAdress
    }
    
    func getCurrentPlayerUsername() -> String {
        return dataService.currentPlayer.username
    }
    
    func getCurrentPlayerDateOfRegistration() -> String {
        return dataService.currentPlayer.dateOfRegistration
    }
    
    func getCurrentPlayerScore() -> Int {
        return dataService.currentPlayer.averageScore
    }
    
}
