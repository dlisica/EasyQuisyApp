import UIKit

class LeaderboardRow: UITableViewCell {
    
    var playerNumber: Int!
    var playerName: String!
    var playerScore: Int!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        setLayout()
    }
    
    func setRow(playerNumber: Int, playerName: String, playerScore: Int) {
        self.playerNumber = playerNumber
        self.playerName = playerName
        self.playerScore = playerScore
    }
    
    private func setLayout() {
        self.backgroundColor = SystemDesign.backgroundColor
        
        let numberLabel = UILabel()
        numberLabel.text = String(describing: playerNumber!)
        numberLabel.textAlignment = .center
        self.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(10)
            maker.top.equalToSuperview().offset(10)
            maker.bottom.equalToSuperview().offset(-10)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = playerName
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textAlignment = .center
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(numberLabel.snp.right).offset(10)
            maker.top.equalToSuperview().offset(10)
            maker.bottom.equalToSuperview().offset(-10)
        }
        
        let scoreLabel = UILabel()
        scoreLabel.text = String(describing: playerScore!)
        scoreLabel.textAlignment = .center
        self.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-10)
            maker.top.equalToSuperview().offset(10)
            maker.bottom.equalToSuperview().offset(-10)
        }
        
    }

}
