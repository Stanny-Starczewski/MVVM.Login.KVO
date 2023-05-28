import UIKit

final class SuccessViewController: UIViewController {
    
    private let successLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        successLabel.text = "🌝"
        successLabel.font = .systemFont(ofSize: 100)
    }

    private func setupLayout() {
        view.addSubview(successLabel)
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            successLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
