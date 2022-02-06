import Foundation

struct Question: Equatable, Codable {
    
    let question: String
    let answers: [String]
    let correctAnswer: Int
    
}
