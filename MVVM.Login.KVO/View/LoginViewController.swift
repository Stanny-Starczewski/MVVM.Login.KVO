import UIKit

final class LoginViewController: UIViewController {
    
    let scrollView = UIScrollView()
    private let loginLabel = UILabel()
    private let passwordLabel = UILabel()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let errorLabel = UILabel()
    private let loginButton = UIButton()
    
    private var isLoginAllowedBinding: NSObject?
    private var errorMessageBinding: NSObject?
    
    private var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboard()
        setupUI()
        setupLayout()
    }
    
    deinit {
        removeKeyboardEvents()
    }
    
    func initialize(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        bind()
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        
        isLoginAllowedBinding = viewModel.observe(\.isLoginAllowed,
                                                   options: [.new],
                                                   changeHandler: { [weak self] _, change in
            
            guard let newValue = change.newValue else { return }
            self?.setLoginButton(enabled: newValue)
        })
        
        errorMessageBinding = viewModel.observe(\.errorMessage,
                                                 options: [.new],
                                                 changeHandler: { [weak self] _, change in
            
            guard let newValue = change.newValue else { return }
            self?.setError(newValue)
        })
    }
    
    private func setLoginButton(enabled: Bool) {
        loginButton.isUserInteractionEnabled = enabled
        loginButton.backgroundColor = enabled ? .orange : .lightGray
    }
    
    private func setError(_ message: String?) {
        errorLabel.isHidden = message == nil
        errorLabel.text = message
    }
    
    @objc
    private func textFieldDidChange() {
        viewModel?.didEnter(
            Credentials(login: self.loginTextField.text,
                        password: self.passwordTextField.text)
        )
    }
    
    private func configureKeyboard() {
        hideKeyboardWhenTappedAround()
        addKeyboardEvents()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [loginTextField, passwordTextField, loginButton].forEach { $0.layer.cornerRadius = 8 }
        
        [loginTextField, passwordTextField].forEach {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 1))
            $0.leftViewMode = .always
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        loginLabel.text = "Логин"
        passwordLabel.text = "Пароль"
        
        loginButton.setTitle("Далее", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        setLoginButton(enabled: false)
        
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
    }
        
    @objc
    private func didTapLoginButton() {
        show(SuccessViewController(), sender: nil)
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        [loginLabel, passwordLabel, loginTextField, passwordTextField, errorLabel, loginButton].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            loginLabel.heightAnchor.constraint(equalToConstant: screenHeight * 0.04),
            loginLabel.widthAnchor.constraint(equalToConstant: screenWidth * 0.8),
            loginLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 4),
            loginTextField.heightAnchor.constraint(equalToConstant: screenHeight * 0.04),
            loginTextField.widthAnchor.constraint(equalToConstant: screenWidth * 0.8),
            loginTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 40),
            passwordLabel.heightAnchor.constraint(equalToConstant: screenHeight * 0.04),
            passwordLabel.widthAnchor.constraint(equalToConstant: screenWidth * 0.8),
            passwordLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 4),
            passwordTextField.heightAnchor.constraint(equalToConstant: screenHeight * 0.04),
            passwordTextField.widthAnchor.constraint(equalToConstant: screenWidth * 0.8),
            passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 80),
            errorLabel.widthAnchor.constraint(equalToConstant: screenWidth * 0.8),
            errorLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 80),
            loginButton.heightAnchor.constraint(equalToConstant: screenHeight * 0.06),
            loginButton.widthAnchor.constraint(equalToConstant: screenWidth * 0.8),
            loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
}
