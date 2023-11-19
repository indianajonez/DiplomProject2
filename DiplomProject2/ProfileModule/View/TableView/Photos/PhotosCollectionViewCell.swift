//
//  PhotosCollectionViewCell.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private properties
    
    private lazy var imageCollectionCellView: UIImageView = {
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
    
    func setupCollectionCell(_ photo: UIImage) {
        imageCollectionCellView.image = photo
    }
    
    
    // MARK: - Private methods
    
    private func setupConstrains() {
        
        contentView.addSubview(imageCollectionCellView)
        
        NSLayoutConstraint.activate([
            imageCollectionCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCollectionCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCollectionCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCollectionCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

