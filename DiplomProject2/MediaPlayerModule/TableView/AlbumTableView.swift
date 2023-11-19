//
//  AlbumTableView.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//


import UIKit

final class AlbumTableViewCell: UITableViewCell {
    
    //MARK: - Public properties

    var album: Album? {
        didSet {
            if let album = album {
                albumCoverView.image = UIImage(named: album.image)
                albumName.text = album.name
                songsCount.text = "\(album.songs.count) Songs"
            }
        }
    }
    
    //MARK: - Private properties
    
    private lazy var albumCoverView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.layer.cornerRadius = 25
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        return v
    }()
    
    private lazy var albumName: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        v.textColor = UIColor(named: "titleColor")
      return v
    }()
    
    private lazy var songsCount: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        v.textColor = .darkGray
        v.numberOfLines = 0
        v.textColor = UIColor(named: "subtitleColor")
        
        return v
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func setupView() {
        [albumCoverView, albumName, songsCount].forEach { (v) in
            contentView.addSubview(v)
        }
        setupConstraints()
    }
    
    //MARK: - Private methods
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            albumCoverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            albumCoverView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            albumCoverView.widthAnchor.constraint(equalToConstant: 100),
            albumCoverView.heightAnchor.constraint(equalToConstant: 100),
            albumCoverView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
        
            albumName.leadingAnchor.constraint(equalTo: albumCoverView.trailingAnchor, constant: 16),
            albumName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            albumName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
        
            songsCount.leadingAnchor.constraint(equalTo: albumCoverView.trailingAnchor, constant: 16),
            songsCount.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 8),
            songsCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            songsCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
