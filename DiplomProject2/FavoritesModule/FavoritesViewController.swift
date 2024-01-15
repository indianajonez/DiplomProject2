//
//  FavoritesViewController.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var favoriteData: [NSManagedObject] = []
    
    private var coreDataManager = CoreDataManager.shared
    
    private lazy var postTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(FavoritesPostTableViewCell.self, forCellReuseIdentifier: String(describing: FavoritesPostTableViewCell.self))
        return table
    }()
    
    //MARK: - Life cycls

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Избранное"
        setupView()
        setupConstraints()
        getFromCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFromCoreData()
        
    }
    
    //MARK: - Private methods
    
    //TODO: Зачем на главный поток переводить? Разве ты была на фоновом при получении постов из кор даты? Также зачем в кложуре [weak self]? У тебя есть retain cycle?
    
    
     func getFromCoreData() {
         
         //TODO: Попробовала перевести на backgroud поток, но теперь выводит в консоль сообщение - "CUICatalog: Invalid asset name supplied: ''" и не показывает данные постов
        
        CoreDataManager.shared.appDelegate.persistentContainer.performBackgroundTask { [weak self] context in
                guard let self = self else { return }

                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PostStorage")
                do {
                    self.favoriteData = try context.fetch(fetchRequest)

                    // Обновление UI должно выполняться на основном потоке
                    DispatchQueue.main.async {
                        self.postTableView.reloadData()
                    }
                } catch {
                    // Обработка ошибок запроса CoreData
                    print("Error fetching data from CoreData: \(error)")
                }
            }
        }
         
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PostStorage")
//        favoriteData = CoreDataManager.shared.fetchData(fetchRequest)
//        DispatchQueue.main.async { [weak self] in // как отправить не на главный поток
//            guard let self = self else {return}
//            self.postTableView.reloadData()
//        }
//        self.postTableView.reloadData()
//    }
    
    private func setupView() {
        view.addSubview(postTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            // таблица
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
}

//MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                coreDataManager.delete(favoriteData[indexPath.row])
                getFromCoreData()
            }
        }
    
}

//MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postTableView.dequeueReusableCell(withIdentifier: String(describing: FavoritesPostTableViewCell.self), for: indexPath) as? FavoritesPostTableViewCell else {return UITableViewCell()}
        cell.setup(post: favoriteData[indexPath.row])
        return cell
    }
}
