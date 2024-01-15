//
//  TabBarController.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - Public properties
    
    let profileVC: ProfileViewController?
    let mediaVC = MediaPlayerViewController()
    let favorietsVC = FavoritesViewController()
    
    //MARK: - Init
    
    init(profileVC: ProfileViewController?) {
        self.profileVC = profileVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.tintColor = .black
        navigationItem.hidesBackButton = true
        setupControllers()
    }
    
    //MARK: - Public methods
    
    func setupControllers() {
        
        guard let profile = profileVC else {return}
        
        profile.tabBarItem.title = "Профайл"
        mediaVC.tabBarItem.title = "Медиа"
        favorietsVC.tabBarItem.title = "Избранное"
        
        profile.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        mediaVC.tabBarItem.image = UIImage(systemName: "play.circle")
        favorietsVC.tabBarItem.image = UIImage(systemName: "star.circle")
        
        
        let profileVC = UINavigationController(rootViewController: profile)
        let mediaVC = UINavigationController(rootViewController: mediaVC)
        let favoritesVC = UINavigationController(rootViewController: favorietsVC)
        viewControllers = [profileVC, mediaVC, favoritesVC]
        }
    }

