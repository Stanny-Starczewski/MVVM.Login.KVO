import Foundation

@objcMembers
final class LoginViewModel: NSObject {
    
    dynamic private(set) var isLoginAllowed: Bool = false
    dynamic private(set) var errorMessage: String? = nil
    
    private let model: LoginModel
    
    init(for model: LoginModel) {
        self.model = model
    }
    
    func didEnter(_ credentials: Credentials) {
        let result = model.didEnter(credentials)
        
        switch result {
        
        case .success(let result):
            isLoginAllowed = result
            errorMessage = nil
        
        case .failure(let error):
            isLoginAllowed = false
            if let error = error as? LoginError {
                errorMessage = error.localizedDescription
            }
        }
    }
}
