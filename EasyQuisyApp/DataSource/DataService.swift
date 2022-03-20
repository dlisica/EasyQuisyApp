import Foundation

//temporary class
class DataService {
    
    private static let dataService = DataService()
    
    static func getDataService() -> DataService {
        return dataService
    }
    
    var currentPlayer: Player
    
    init() {
        currentPlayer = Player(emailAdress: "email", username: "Admin", password: "password", dateOfRegistration: "1999-12-17")
    }

}
