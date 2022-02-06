import Foundation

enum Status {

    case success
    case error(String)
    
    func getMessage() -> String? {
        switch self {
        case .success:
            return nil
        case .error(let string):
            return string
        }
    }

}
