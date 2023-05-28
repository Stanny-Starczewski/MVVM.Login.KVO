import UIKit

extension LoginViewController {
    var notificationCenter: NotificationCenter { NotificationCenter.default }
    
    func addKeyboardEvents() {
        notificationCenter.addObserver(self,
                                       selector: #selector(self.keyboardWillShowNotification),
                                       name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(self.keyboardWillHideNotification),
                                       name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardEvents() {
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShowNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let editedField = scrollView.subviews.filter({ $0 is UITextField && $0.isFirstResponder }).first
        else { return }
        
        if keyboardFrame.contains(editedField.frame.origin) {
            let scrollPoint = CGPoint(x: 0, y: editedField.frame.origin.y - keyboardFrame.height)
            scrollView.setContentOffset(scrollPoint, animated: true)
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        }
    }
    
    @objc func keyboardWillHideNotification(notification: NSNotification) {
        scrollView.contentInset = .zero
    }
}
