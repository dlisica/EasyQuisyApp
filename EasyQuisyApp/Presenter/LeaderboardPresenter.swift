import Foundation

class LeaderboardPresenter {
    
    private var dataService = DataService.getDataService()
    
    private var leaderboard = [Player]() {
        didSet {
            leaderBoardViewDelegate?.updateUI()
        }
    }
    
    weak private var leaderBoardViewDelegate: LeaderboardViewDelegate?
    
    func setViewDelegate(leaderBoardViewDelegate: LeaderboardViewDelegate?){
        self.leaderBoardViewDelegate = leaderBoardViewDelegate
    }
    
    init() {
        refreshLeaderboard()
    }
    
    private func refreshLeaderboard() {
        NetworkService.fetchLeaderboard() { (leaderboard: [Player]) in
            self.leaderboard = leaderboard
        }
    }
    
    func getNumberOfPlayers() -> Int {
        return leaderboard.count
    }
    
    func getPlayer(atIndex index: Int) -> Player {
        return leaderboard[index]
    }
    
    func isCurrentPlayer(player: Player) -> Bool {
        return dataService.currentPlayer.id == player.id
    }
    
}
