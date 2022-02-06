import Foundation

struct Quiz: Codable {

    let id: String
    let name: String
    let author: String
    let category: QuizCategory
    let description: String
    let imageUrl: String
    let questions: [Question]

}
