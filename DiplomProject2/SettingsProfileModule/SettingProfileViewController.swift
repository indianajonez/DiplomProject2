//
//  SettingProfileViewController.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

class SettingsProfileViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let settingManager = SettingManager.shared
    
    private var user: User?
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    private lazy var titleChangeOrAddPhotos: UILabel = {
        let label = UILabel()
        label.text = "ФОТО"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addPhotoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white
        image.layer.cornerRadius = 12
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.systemGray3.cgColor
        image.layer.backgroundColor = UIColor.systemGray3.cgColor
        return image
    }()
    
    private lazy var plusView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus.png"), for: .normal)
        button.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleUserName: UILabel = {
        let label = UILabel()
        label.text = "ИМЯ"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textFieldName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите ваше имя "
        textField.borderStyle = .none
        return textField
    }()
    
    private lazy var breaklineView: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.systemGray3.cgColor
        line.layer.backgroundColor = UIColor.systemGray3.cgColor
        
        return line
    }()
    
    private lazy var titleInformationAboutUser: UILabel = {
        let label = UILabel()
        label.text = "О СЕБЕ"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textFieldAboutUser: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Расскажите о себе: увлечения, работа, учеба "
        textField.borderStyle = .none
        return textField
    }()
    
    private lazy var breakline2View: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.systemGray3.cgColor
        line.layer.backgroundColor = UIColor.systemGray3.cgColor
        
        return line
    }()
    
    private lazy var titleAboutUserAge: UILabel = {
        let label = UILabel()
        label.text = "ВОЗРАСТ"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textFieldAge: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Сколько вам лет?"
        textField.borderStyle = .none
        return textField
    }()
    
    private lazy var breakline3View: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.systemGray3.cgColor
        line.layer.backgroundColor = UIColor.systemGray3.cgColor
        return line
    }()
    
    private lazy var saveSettingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.setTitle("СОХРАНИТЬ", for: .normal)
        button.addTarget(self, action: #selector(self.didTapSavedButton), for: .touchUpInside)
        return button
        
    }()
    
    
    //MARK: - Init
    
    init(user: User?) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Настройки"
        self.view.backgroundColor = UIColor.white
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupGradient()
    }
    
    
    
    //MARK: - Private methods
    
    @objc
    private func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    private func setupInfo() {
        guard let user = self.user else {return}
        self.textFieldName.text = user.name
//        self.addPhotoImageView.image = user.avatar
        self.textFieldAge.text = user.age
        self.textFieldAboutUser.text = user.aboutUser
    }
    
    @objc
    private func didTapSavedButton() {
        guard var user = self.user else {return}
        user.name = self.textFieldName.text
//        user.avatar = self.addPhotoImageView.image
        user.age = self.textFieldAge.text
        user.aboutUser = self.textFieldAboutUser.text
        settingManager.isNeedUpdate = true
        navigationController?.popViewController(animated: true)
    }
    
    
    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = saveSettingsButton.bounds
        gradient.cornerRadius = 10
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemRed.cgColor]
        saveSettingsButton.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(titleChangeOrAddPhotos)
        scrollView.addSubview(addPhotoImageView)
        scrollView.addSubview(titleUserName)
        scrollView.addSubview(textFieldName)
        scrollView.addSubview(breaklineView)
        scrollView.addSubview(plusView)
        scrollView.addSubview(titleInformationAboutUser)
        scrollView.addSubview(textFieldAboutUser)
        scrollView.addSubview(breakline2View)
        scrollView.addSubview(titleAboutUserAge)
        scrollView.addSubview(textFieldAge)
        scrollView.addSubview(breakline3View)
        scrollView.addSubview(saveSettingsButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleChangeOrAddPhotos.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            titleChangeOrAddPhotos.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            titleChangeOrAddPhotos.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            titleChangeOrAddPhotos.heightAnchor.constraint(equalToConstant: 30),
            
            addPhotoImageView.topAnchor.constraint(equalTo: titleChangeOrAddPhotos.bottomAnchor, constant: 30),
            addPhotoImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            addPhotoImageView.heightAnchor.constraint(equalToConstant: 150),
            addPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            plusView.centerYAnchor.constraint(equalTo: addPhotoImageView.centerYAnchor),
            plusView.centerXAnchor.constraint(equalTo: addPhotoImageView.centerXAnchor),
            
            titleUserName.topAnchor.constraint(equalTo: addPhotoImageView.bottomAnchor, constant: 30),
            titleUserName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            titleUserName.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            textFieldName.topAnchor.constraint(equalTo: titleUserName.bottomAnchor, constant: 30),
            textFieldName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textFieldName.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            textFieldName.heightAnchor.constraint(equalToConstant: 30),
            
            breaklineView.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 2),
            breaklineView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            breaklineView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            breaklineView.heightAnchor.constraint(equalToConstant: 2),
            
            titleInformationAboutUser.topAnchor.constraint(equalTo: breaklineView.bottomAnchor, constant: 30),
            titleInformationAboutUser.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleInformationAboutUser.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            textFieldAboutUser.topAnchor.constraint(equalTo: titleInformationAboutUser.bottomAnchor, constant: 50),
            textFieldAboutUser.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textFieldAboutUser.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            textFieldAboutUser.heightAnchor.constraint(equalToConstant: 30),
            
            breakline2View.topAnchor.constraint(equalTo: textFieldAboutUser.bottomAnchor, constant: 2),
            breakline2View.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            breakline2View.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            breakline2View.heightAnchor.constraint(equalToConstant: 2),
            
            titleAboutUserAge.topAnchor.constraint(equalTo: breakline2View.bottomAnchor, constant: 50),
            titleAboutUserAge.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleAboutUserAge.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            textFieldAge.topAnchor.constraint(equalTo: titleAboutUserAge.bottomAnchor, constant: 30),
            textFieldAge.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textFieldAge.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            textFieldAge.heightAnchor.constraint(equalToConstant: 30),
            
            breakline3View.topAnchor.constraint(equalTo: textFieldAge.bottomAnchor, constant: 2),
            breakline3View.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            breakline3View.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -240),
            breakline3View.heightAnchor.constraint(equalToConstant: 2),
            
            saveSettingsButton.topAnchor.constraint(equalTo: breakline3View.bottomAnchor, constant: 30),
            saveSettingsButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            saveSettingsButton.heightAnchor.constraint(equalToConstant: 50),
            saveSettingsButton.widthAnchor.constraint(equalToConstant: 300),
            saveSettingsButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
            
        ])
    }
}


//MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension SettingsProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        dismiss(animated: true)
        self.addPhotoImageView.image = image
    }
}

