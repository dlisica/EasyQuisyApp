import UIKit

protocol LeaderboardViewDelegate: NSObjectProtocol {
    func updateUI()
}

class LeaderboardViewController: UIViewController, LeaderboardViewDelegate {
  
    private let leaderboardPresenter = LeaderboardPresenter()
    
    private var leaderboardTableView: UITableView!
    
    let cellIdentifier = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaderboardPresenter.setViewDelegate(leaderBoardViewDelegate: self)

        setLayout()
        setTableView()
    }
    
    func setLayout() {
        self.view.backgroundColor = SystemDesign.backgroundColor
        self.navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = TitleUILabel(textSize: 25)
        
        let titleLabel : UILabel = TitleUILabel(textSize: 45.0)
        titleLabel.text = "Leaderboard"
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(300)
            maker.height.equalTo(50)
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(100)
        }
        
        leaderboardTableView = UITableView()
        leaderboardTableView.backgroundColor = SystemDesign.backgroundColor
        self.view.addSubview(leaderboardTableView)
        leaderboardTableView.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(titleLabel.snp.bottom).offset(30)
            maker.bottom.equalToSuperview().offset(-50)
            maker.left.equalToSuperview().offset(10)
            maker.right.equalToSuperview().offset(-10)
        }
        
    }
    
    private func setTableView() {
        leaderboardTableView.register(LeaderboardRow.self, forCellReuseIdentifier: cellIdentifier)
        leaderboardTableView.dataSource = self
        leaderboardTableView.delegate = self
    }
    
    func updateUI() {
        leaderboardTableView.reloadData()
    }
    
}

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardPresenter.getNumberOfPlayers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LeaderboardRow = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LeaderboardRow
        
        let player = leaderboardPresenter.getPlayer(atIndex: indexPath.row)
        cell.setRow(playerNumber: indexPath.row+1, playerName: player.username, playerScore: player.averageScore)
        cell.selectionStyle = .none
        
        if leaderboardPresenter.isCurrentPlayer(player: player) {
            cell.contentView.backgroundColor = .systemRed
        }
    
        return cell
    }
    
}
