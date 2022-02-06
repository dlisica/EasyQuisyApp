import UIKit

protocol SettingsViewDelegate : NSObjectProtocol {
}

class SettingsViewController: UIViewController, SettingsViewDelegate {
    
    private let settingsPresenter = SettingsPresenter(dataService: DataService.getDataService())
    
    private var leaderboardButton: CustomUIButton!
    private var changePasswordButton: CustomUIButton!
    private var logoutButton: CustomUIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsPresenter.setViewDelegate(settingsViewDelegate: self)
        
        setLabelsLayout()
        setButtonsLayout()
        addButtonFunctions()
    }
    
    private func setLabelsLayout() {
        self.view.backgroundColor = SystemDesign.backgroundColor
        navigationItem.titleView = TitleUILabel(textSize: 25)
        
        let titleLabel : UILabel = TitleUILabel(textSize: 45.0)
        titleLabel.text = "Settings"
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(250)
            maker.height.equalTo(50)
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(100)
        }
        
        let usernameLabel = SmallUILabel(text: "Username")
        self.view.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        let usernameProperty = BigUILabel(text: settingsPresenter.getCurrentPlayerUsername())
        self.view.addSubview(usernameProperty)
        usernameProperty.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(usernameLabel.snp.bottom).offset(10)
        }
        
        let emailLabel = SmallUILabel(text: "E-mail adress")
        self.view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(usernameProperty.snp.bottom).offset(40)
        }
        
        let emailProperty = BigUILabel(text: settingsPresenter.getCurrentPlayerEmail())
        self.view.addSubview(emailProperty)
        emailProperty.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(emailLabel.snp.bottom).offset(10)
        }
        
        let dateOfRegLabel = SmallUILabel(text: "Date of registration")
        self.view.addSubview(dateOfRegLabel)
        dateOfRegLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(emailProperty.snp.bottom).offset(40)
        }
        
        let dateOfReg = settingsPresenter.getCurrentPlayerDateOfRegistration()
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-DD"
        let showDate = inputFormatter.date(from: dateOfReg)
        inputFormatter.dateFormat = "d MMM y"
        let date = inputFormatter.string(from: showDate!)
        
        let dateOfRegProperty = BigUILabel(text: date)
        self.view.addSubview(dateOfRegProperty)
        dateOfRegProperty.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(dateOfRegLabel.snp.bottom).offset(10)
        }
        
        let scoreLabel = SmallUILabel(text: "Score")
        self.view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(dateOfRegProperty.snp.bottom).offset(40)
        }
        
        let scoreProperty = BigUILabel(text: String(settingsPresenter.getCurrentPlayerScore()))
        self.view.addSubview(scoreProperty)
        scoreProperty.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(scoreLabel.snp.bottom).offset(10)
        }
        
    }
    
    private func setButtonsLayout() {
        logoutButton = CustomUIButton(text: "Logout")
        self.view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-100)
        }
        
        changePasswordButton = CustomUIButton(text: "Change password")
        self.view.addSubview(changePasswordButton)
        changePasswordButton.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(logoutButton.snp.top).offset(-10)
        }
        
        leaderboardButton = CustomUIButton(text: "Leaderboard")
        self.view.addSubview(leaderboardButton)
        leaderboardButton.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(changePasswordButton.snp.top).offset(-10)
        }
    }
    
    private func addButtonFunctions() {
        leaderboardButton.addTarget(self, action: #selector(showLeaderboard), for: .touchUpInside)
        changePasswordButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc
    private func showLeaderboard() {
        self.navigationController?.pushViewController(LeaderboardViewController(), animated: true)
    }
    
    @objc
    private func changePassword() {
        self.navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
    }
    
    @objc
    private func logout() {
        self.view.window!.rootViewController = LoginViewController()
    }
    
}
