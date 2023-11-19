//
//  FriendsCollectionViewCell.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

class FrinedsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private properties
    
    private lazy var imageCollectionViewCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods
    
    func setupCollectionFrinedsCell(_ photo: UIImage) {
        imageCollectionViewCell.image = photo
    }
    
    
    // MARK: - Private methods
    
    private func setupConstrains() {
        
        contentView.addSubview(imageCollectionViewCell)
        
        NSLayoutConstraint.activate([
            imageCollectionViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCollectionViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCollectionViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCollectionViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

