//
//  ProfileHeaderView.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    
    //MARK: - Private properties
    
    private lazy var avatarImageView: UIImageView = {
        var image = UIImageView(image: UIImage(named: "Kate"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kate"
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        return label
    }()
    
    private lazy var labelUserName: UILabel = {
        let label = UILabel()
        label.text = "Имя заданное в настройках"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelAboutUser: UILabel = {
        let label = UILabel()
        label.text = "текст из настроек"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var iconAgeView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "1cake.png")
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var labelAge: UILabel = {
        let label = UILabel()
        label.text = "возраст из настроек"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var iconAboutUserView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "card.png")
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var iconEmailView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "email.png")
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [ fullNameLabel, labelUserName, labelAboutUser, labelAge, avatarImageView, iconAgeView, iconAboutUserView, iconEmailView].forEach{addSubview($0)}
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods
    
    func setupView(user: User?) {
        if let user = user {
            self.fullNameLabel.text = user.fullName
            self.avatarImageView.image = user.avatar
            self.labelUserName.text = user.name
            self.labelAboutUser.text = user.aboutUser
            self.labelAge.text = user.age
        }
    }
    
    func updateInfo(user: User?) {
        guard let user = user else {return}
        self.avatarImageView.image = user.avatar
        self.labelAboutUser.text = user.aboutUser
        self.labelAge.text = user.age
        self.labelUserName.text = user.name
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            labelUserName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            labelUserName.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            
            iconAboutUserView.topAnchor.constraint(equalTo: labelUserName.bottomAnchor, constant: 15),
            iconAboutUserView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            
            labelAboutUser.topAnchor.constraint(equalTo: labelUserName.bottomAnchor, constant: 15),
            labelAboutUser.leadingAnchor.constraint(equalTo: iconAboutUserView.trailingAnchor, constant: 4),
            
            iconAgeView.topAnchor.constraint(equalTo: labelAboutUser.bottomAnchor, constant: 15),
            iconAgeView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            
            labelAge.topAnchor.constraint(equalTo: labelAboutUser.bottomAnchor, constant: 15),
            labelAge.leadingAnchor.constraint(equalTo: iconAgeView.trailingAnchor, constant: 4),
            
            iconEmailView.topAnchor.constraint(equalTo: labelAge.bottomAnchor, constant: 15),
            iconEmailView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            
            fullNameLabel.topAnchor.constraint(equalTo: labelAge.bottomAnchor, constant: 15),
            fullNameLabel.leadingAnchor.constraint(equalTo: iconEmailView.trailingAnchor, constant: 8),

        ])

    }

}

