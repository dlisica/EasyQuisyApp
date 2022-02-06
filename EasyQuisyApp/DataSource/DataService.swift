import Foundation

class DataService {
    
    private static let dataService = DataService()
    
    static func getDataService() -> DataService {
        return dataService
    }
    
    private var networkService = NetworkService()
    
    var currentPlayer: Player
    
    var quizzes = [Quiz]()
    var leaderboard = [Player]()
    
    init() {
        networkService.fetchQuizzes()
        networkService.fetchLeaderboard()
        currentPlayer = Player(emailAdress: "email", username: "Admin", password: "password", dateOfRegistration: "1999-12-17")
    }
    
    func registerPlayer(emailAdress: String, username: String, password: String) {
        networkService.registerPlayer(emailAdress: emailAdress, username: username, password: password)
    }
    
    //handle errors
    func loginPlayer(username: String, password: String) -> Status {
        networkService.loginPlayer(username: username, password: password)
        return .success
    }
    
    //handle errors
    func changePassword(oldPassword: String, newPassword: String) -> Status {
        networkService.changePassword(playerId: currentPlayer.id, oldPassword: oldPassword, newPassword: newPassword)
        return .error("nes promijenit")
    }
    
    func submitQuizResult(playerId: String, quizId: String, playingTime: Double, score: Int) {
        networkService.submitQuizResult(playerId: playerId, quizId: quizId, playingTime: playingTime, score: score)
    }
    
}
