import Foundation

class LeaderboardPresenter {
    
    private let dataService : DataService
    weak private var leaderBoardViewDelegate : LeaderboardViewDelegate?
    
    init(dataService : DataService) {
        self.dataService = dataService
    }
    
    func setViewDelegate(leaderBoardViewDelegate : LeaderboardViewDelegate?){
        self.leaderBoardViewDelegate = leaderBoardViewDelegate
    }
    
    func getLeaderboard() -> [Player] {
        return dataService.leaderboard
    }
    
    func isCurrentPlayer(player: Player) -> Bool {
        return player.id == dataService.currentPlayer.id
    }
    
}
