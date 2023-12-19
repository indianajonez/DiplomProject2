//
//  ProfileViewController.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    // MARK: - Public properties
    
    
    let user: User?
    
    
    // MARK: - Privte properties
    
    private var listPost = Post2.make()
    private var listfFiendsPhoto = Photo.makeCollectionPhotos(type: .friends)
    private var listPhoto = Photo.makeCollectionPhotos(type: .photo)
    private let settingManager = SettingManager.shared
    private let header = ProfileHeaderView()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        table.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.identifier)
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return table
    }()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Мой профайл"
        setupView()
        setupConstraints()
        makeBarButtonItems()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if settingManager.isNeedUpdate {
            header.updateInfo(user: self.user)
            settingManager.isNeedUpdate = false
           
        }
    }
    
    // MARK: - Init
    
    init(user: User?) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private methods
    
    private func setupView() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func makeBarButtonItems() {
        let edit = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(editTapped))
        let logout = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(logoutTapped))
        
        navigationItem.rightBarButtonItems = [logout, edit]
        edit.tintColor = .black
        logout.tintColor = .black
    }
    
    @objc
    func editTapped() {
        let settingsProfileVC = SettingsProfileViewController(user: self.user)
        navigationController?.pushViewController(settingsProfileVC, animated: true)
    }
    
    @objc
    func logoutTapped() {
        let loginVC = LoginViewController(checkerService: CheckerService())
        ManagerUserDefaults.shared.setSessionStatus(false)
        navigationController?.pushViewController(loginVC, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
}



// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension // автоматическая высота ячеек ( зависти от контента)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header.setupView(user: user) //как здесь правильно прописать?
        header.backgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .black)
        header.layer.cornerRadius = 30
        return section == 0 ? header : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 220 : 0
    }
}


// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else {
            return listPost.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier) as? FriendsTableViewCell else { return UITableViewCell()}
            cell.delegate = self
            cell.backgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .black)
            cell.layer.cornerRadius = 30
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier) as? PhotosTableViewCell else { return UITableViewCell()}
            cell.delegate = self
            cell.backgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .black)
            cell.layer.cornerRadius = 30
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else { return UITableViewCell()}
            cell.setupCell(listPost[indexPath.row])
            cell.backgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .black)
            cell.layer.cornerRadius = 30
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
}

// MARK: - PhotosGalleryDelegate

extension ProfileViewController: PhotosGalleryDelegateProtocol {
    
    func openGalleryPhotos() {
        let galleryVC = PhotosViewController()
        navigationController?.pushViewController(galleryVC, animated: true)
    }
}

// MARK: - FriendsGalleryDelegate

extension ProfileViewController: FriendsGalleryDelegateProtocol {
    func openGalleryFriends() {
        let friendsVC = FriendsViewController()
        navigationController?.pushViewController(friendsVC, animated: true)
    }
}

