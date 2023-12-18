//
//  RegistrationViewController.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    //MARK: - Private properties
    
    //    private let checkerService = CheckerService()
    private var checkerService: CheckerServiceProtocol?
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Регистрация"
        title.font = .boldSystemFont(ofSize: 40)
        title.textColor = .gray
        
        return title
    }()
    
    private lazy var loginTextField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.textColor = UIColor.createColor(lightMode: .black, darkMode: .white) //Palette.labelColor
        login.layer.backgroundColor = UIColor.createCGolor(lightMode: .systemGray6, darkMode: .darkGray)
        login.layer.borderColor = UIColor.createCGolor(lightMode: .systemGray4, darkMode: .systemGray2)
        login.layer.borderWidth = 0.5
        login.leftViewMode = .always
        login.placeholder = "введите логин - email"
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
        password.placeholder = "введите пароль"
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        return password
        
    }()
    
    private lazy var repeatPasswordTextField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        password.layer.backgroundColor = UIColor.createCGolor(lightMode: .systemGray6, darkMode: .darkGray)
        password.layer.borderColor = UIColor.createCGolor(lightMode: .systemGray4, darkMode: .systemGray2)
        password.layer.borderWidth = 0.5
        password.leftViewMode = .always
        password.placeholder = "повторите пароль"
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
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray //UIColor.createColor(lightMode: UIColor(rgb: 0x4885CC), darkMode: UIColor(rgb: 0x666666))
        button.layer.cornerRadius = 10
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(self.tapRegister), for: .touchUpInside)
        return button
    }()
    
    //MARK: -Init
    
    init(checkerService: CheckerServiceProtocol) { //TODO: done унифицицировала ( убрала композицию, пораждение за счет конструктора)
        super.init(nibName: nil, bundle: nil)
        self.checkerService = checkerService
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycls
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    //MARK: - Private methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            registrationButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            registrationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        setupStackView()
        scrollView.addSubview(registrationButton)
        scrollView.addSubview(titleLabel)
        
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(self.loginTextField)
        stackView.addArrangedSubview(self.passwordTextField)
        stackView.addArrangedSubview(self.repeatPasswordTextField)
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
    
    //TODO: А если я введ пробелы? " " - это разве валидно?)
    
    @objc private func tapRegister() {
        
        guard let login = loginTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        guard let repeatPass = repeatPasswordTextField.text else {return}
        
        
        if pass != repeatPass {
            self.makeWrongAlert(massage: "Пароль неверный")
            return
        }
        
        self.checkerService?.singUp(email: login, pass: pass) { check, errorString in
            guard let errorString else {
                if check {
                    self.checkerService?.logIn(email: login, pass: pass) { user, error in
                        let profileVC = ProfileViewController(user: user)
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                            return
                        }
                        let tabbar = TabBarController(profileVC: profileVC)
                        sceneDelegate.window?.rootViewController = tabbar
                        
                        
                        
                        //TODO: То есть я могу вернуться на экран регистрации и логина?) Это как? Вы должны подменять рутовый контроллер окна у сцен делегата. Для этого надо добраться до сцен делегата, взять его окно и подменить rootViewController
                        
                        //self.navigationController?.pushViewController(profileVC, animated: true) //TODO: Не поправлено
                    }
                }
                return
            }
            //self.navigationController?.popViewController(animated: true)
            self.makeWrongAlert(massage: errorString)
        }
    }
}
