import Foundation

enum LoginError: Error {
    case invalidCharacter
    case longString
    
    var localizedDescription: String {
        switch self {
        case .invalidCharacter: return "Поле может содержать только цифры от 0 до 9!"
        case .longString:       return "Максимальная длина строки - 4 символа!"
        }
    }
}
