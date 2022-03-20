import Foundation

enum RequestError: String, Error {
    case clientError = "Client error"
    case serverError = "Server error"
    case noDataError = "No data error"
    case dataDecodingError = "Data decoding error"
}

class NetworkService {
    
    static let baseUrl = "http://easy-quisy-api.herokuapp.com"
    
    static func executeUrlRequest<T>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void) where T : Decodable {
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.clientError))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noDataError))
                }
                return
            }
            
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.dataDecodingError))
                }
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(.success(value))
            }
            
        }
        
        dataTask.resume()
    }
    
    static func fetchQuizzes(returnQuizzes: @escaping ([Quiz]) -> Void) {
        
        guard let url = URL(string: baseUrl+"/quiz") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        executeUrlRequest(request) { (result: Result<[Quiz], RequestError>) in
            switch result {
            case .failure(let error):
                print("Fetch quizzes: \(error) occured!")
                returnQuizzes([Quiz]())
            case .success(let value):
                print("Quizzes fetched successfully!")
                returnQuizzes(value)
            }
        }
    }
    
    static func fetchLeaderboard(returnLeaderboard: @escaping ([Player]) -> Void) {
        
        guard let url = URL(string: baseUrl+"/player/leaderboard") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        executeUrlRequest(request) { (result: Result<[Player], RequestError>) in
            switch result {
            case .failure(let error):
                print("Fetch leaderboard: \(error) occured!")
                returnLeaderboard([Player]())
            case .success(let value):
                print("Leaderboard fetched successfully!")
                returnLeaderboard(value)
            }
        }
    }
    
    static func registerPlayer(emailAdress: String, username: String, password: String, updateUI: @escaping (Status) -> Void) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        guard let url = URL(string: baseUrl+"/player/insert") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["emailAdress": emailAdress,
                                   "username": username,
                                   "password": password,
                                   "dateOfRegistration": dateString]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        executeUrlRequest(request) { (result: Result<Player, RequestError>) in
            switch result {
            case .failure(let error):
                print("Register player: \(error) occured!")
                updateUI(Status.error("Username is already taken!"))
            case .success(let value):
                print("Register player ID: \(value.id)")
                updateUI(Status.success)
            }
        }
    }
    
    static func loginPlayer(username: String, password: String, updateUI: @escaping (Status) -> Void) {
        
        guard let url = URL(string: baseUrl+"/player/login") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["username": username,
                                   "password": password]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        executeUrlRequest(request) { (result: Result<Player, RequestError>) in
            switch result {
            case .failure(let error):
                print("Login player: \(error) occured!")
                updateUI(Status.error(error.rawValue))
            case .success(let value):
                print("Logged player with ID: \(value.id)")
                DataService.getDataService().currentPlayer = value  //remove later
                updateUI(Status.success)
            }
        }
        
    }
    
    static func changePassword(playerId: String, oldPassword: String, newPassword: String, updateUI: @escaping (Status) -> Void) {
      
        guard let url = URL(string: baseUrl+"/player/change-password") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["playerId": playerId,
                                   "oldPassword": oldPassword,
                                   "newPassword": newPassword]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        executeUrlRequest(request) { (result: Result<Player, RequestError>) in
            switch result {
            case .failure(let error):
                print("Change password: \(error) occured!")
                updateUI(Status.error(error.rawValue))
            case .success(let value):
                print("Change password player ID: \(value.id)")
                updateUI(Status.success)
            }
        }
        
    }
    
    static func submitQuizResult(playerId: String, quizId: String, playingTime: Double, score: Int) {
        
        guard let url = URL(string: baseUrl+"/result") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["playerId": playerId,
                                   "quizId": quizId,
                                   "playingTime": playingTime,
                                   "score": score]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        executeUrlRequest(request) { (result: Result<QuizResult, RequestError>) in
            switch result {
            case .failure(let error):
                print("Submit result: \(error) occured!")
            case .success(let value):
                print("Submitted result of quiz with ID: \(value.quizId)")
            }
        }
        
    }
    
}
