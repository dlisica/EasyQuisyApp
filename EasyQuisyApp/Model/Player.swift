import Foundation

struct Player: Codable, Equatable {
    
    let id: String
    let emailAdress: String
    let username: String
    var password: String
    let dateOfRegistration: String
    var numberOfPlays: Int
    var averageScore: Int
    var averagePlayingTime: Double
    
    init(emailAdress: String, username: String, password: String, dateOfRegistration: String) {
        self.id = "0000"
        self.emailAdress = emailAdress
        self.username = username
        self.password = password
        self.dateOfRegistration = dateOfRegistration
        self.numberOfPlays = 0
        self.averageScore = 0
        self.averagePlayingTime = 0.0
    }
    
    mutating func setScore(newScore: Int) {
        self.averageScore = newScore
    }
    
}
