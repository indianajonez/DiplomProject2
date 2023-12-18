//
//  LoginViewController.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit
import FirebaseAuth

//TODO: Почему в Login checkerService закрыт протоколом и инджектится через конструктор, а в RegistrationViewController у вас композиция, и checkerService порождается непосредственно контроллером?) Наверное, надо как-то унифицировать. Первый вариант, как в LoginViewController правильнее. DONE

class LoginViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var checkerService: CheckerServiceProtocol?
        
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.layer.shadowColor = UIColor.gray.cgColor
        image.layer.shadowOpacity = 0.3
        image.layer.shadowRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var loginTextField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.textColor = UIColor.createColor(lightMode: .black, darkMode: .white) //Palette.labelColor
        login.layer.backgroundColor = UIColor.createCGolor(lightMode: .systemGray6, darkMode: .darkGray)
        login.layer.borderColor = UIColor.createCGolor(lightMode: .systemGray4, darkMode: .systemGray2)
        login.layer.borderWidth = 0.5
        login.leftViewMode = .always
        login.placeholder = "Логин"
        login.autocapitalizationType = .none
        login.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        return login
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        password.layer.backgroundColor = UIColor.createCGolor(lightMode: .systemGray6, darkMode: .darkGray)
        password.layer.borderColor = UIColor.createCGolor(lightMode: .systemGray4, darkMode: .systemGray2)
        password.layer.borderWidth = 0.5
        password.leftViewMode = .always
        password.placeholder = "Пароль"
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        return password
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(self.didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("Зарегистрироваться", for: .normal)
        button.addTarget(self, action: #selector(self.didTapRegistrationButton), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: -Init
    
    init(checkerService: CheckerServiceProtocol) {
        self.checkerService = checkerService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupgestureRecognizer()
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        self.navigationItem.setHidesBackButton(true, animated:true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { auth, user in
            
        }
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(stackView)
        setupStackView()
        scrollView.addSubview(logInButton)
        scrollView.addSubview(registrationButton)
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(self.loginTextField)
        stackView.addArrangedSubview(self.passwordTextField)
    }
    
    private func setupgestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapSuperView))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func makeWrongAlert(massage: String) {
        let alertController = UIAlertController(
            title: "Ошибка",
            message: massage,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 230),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            registrationButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            registrationButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    
    @objc
    private func didTapSuperView() {
        self.view.endEditing(true)
    }
    
    @objc
    private func didTapLoginButton() {
        
        let login = self.loginTextField.text ?? ""
        // нужно добавить и унифицировать forKey { _ in self.userDefaults.setValue(true, forKey: " logged_in ")
        let password = self.passwordTextField.text ?? ""
        checkerService?.logIn(email: login, pass: password) { user, errorString in // NOTTODO: не заходит
            guard let user else {
                self.makeWrongAlert(massage: errorString ?? "Неверный логин или пароль")
                return
            }
            ManagerUserDefaults.shared.setSessionStatus(true)
            ManagerUserDefaults.shared.saveUser(user)
            
            let profileVC = ProfileViewController(user: user)
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
            let tabbar = TabBarController(profileVC: profileVC)
            sceneDelegate.window?.rootViewController = tabbar
            //let profileVC = ProfileViewController(user: user)
            //self.navigationController?.pushViewController(TabBarController(profileVC: profileVC), animated: true)
        }
    }
    
    @objc
    private func didTapRegistrationButton() {
        self.navigationController?.pushViewController(RegistrationViewController(checkerService: CheckerService()), animated: true)
    }
}



