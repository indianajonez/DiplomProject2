//
//  PhotosTableViewCell.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    // MARK: - Public properties
    
    weak var delegate: PhotosGalleryDelegateProtocol?
    
    //MARK: - Private properties
    
    private let collectionPhotos = Photo.makeCollectionPhotos(type: .photo)
    
    // Описание ячейки
    
    private lazy var imageCollectionView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var namelabel: UILabel = {
        let name = UILabel()
        name.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        name.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        name.text = "ФОТО"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)      //(UIImage(named: "Кнопка"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageCollection: UICollectionView = {
        // Коллекция картинок
        let layout = UICollectionViewFlowLayout()
        // Горизонтальное расположение
        layout.scrollDirection = .horizontal
        let imageCollection = UICollectionView(frame: .zero, collectionViewLayout: layout )
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        // Кто будет реагировать на делегиварование
        imageCollection.delegate = self
        // Хранилище дванных
        imageCollection.dataSource = self
        imageCollection.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        imageCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return imageCollection
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { // Момент создания ячеки блока с фотографиями
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstrains()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    
    @objc
    private func tapButton() {
        print("TAP")
        self.delegate?.openGallery()
        print(#function)
    }
    
    private func setupConstrains() {
        
        let labelinset: CGFloat = 12
        
        [namelabel, button, imageCollectionView].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            namelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: labelinset),
            namelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelinset),
            namelabel.bottomAnchor.constraint(equalTo: imageCollectionView.topAnchor, constant: -labelinset),
            
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelinset),
            button.centerYAnchor.constraint(equalTo: namelabel.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 20),
            button.widthAnchor.constraint(equalToConstant: 20),
            
            imageCollectionView.topAnchor.constraint(equalTo: namelabel.bottomAnchor, constant: labelinset),
            imageCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelinset),
            imageCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelinset),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 100),
            imageCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelinset)
            
        ])
    }
    
}
    
 
// MARK: - UICOllectionViewDelegateFlowLayout

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    
    
    // MARK: - Private properties
    
    private var sideInset: CGFloat {return 8}
    
    
    // MARK: - Public methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // От ширины экрана отнимает все отступы (включая первый и последний) и делим на количество элементов
        let width = (collectionView.bounds.width - sideInset * 5) / 4
        // Возвращаем квадратный размер
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // Минимальный отступ между элементами UICollectionView
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }

}



// MARK: - UICollectionViewDataSource

extension PhotosTableViewCell: UICollectionViewDataSource {
    
    
    // MARK: - Public methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else {return UICollectionViewCell()}
        
        if let image = collectionPhotos[indexPath.row].image {
            cell.setupCollectionCell(image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionPhotos.count
    }
    
}

    
    
    
    


