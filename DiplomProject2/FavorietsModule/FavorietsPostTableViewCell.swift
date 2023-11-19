//
//  FavorietsPostTableViewCell.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit
import CoreData


class FavorietsPostTableViewCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private var post: NSManagedObject?
    private var isTapped: Bool = false
    
    private lazy var nameAuthor: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionOfPosts: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageInPostsView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemBackground
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var likesInPosts: UILabel = {
        let likes = UILabel()
        likes.text = "Liks: "
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()
    
    private lazy var postLikesCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postViews: UILabel = {
        let views = UILabel()
        views.text = "Views: "
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    private lazy var postViewsCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tapLikeButton: UIButton = {
           let button = UIButton()
           button.translatesAutoresizingMaskIntoConstraints = false
           button.tintColor = .systemRed
           button.setImage(UIImage(systemName: "heart"), for: .normal)
           button.addTarget(self, action: #selector(addLikes), for: .touchUpInside)
           
           return button
       }()
    
    //MARK: - Life cycls
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func setup(post: NSManagedObject) {
        self.post = post
        self.nameAuthor.text = post.value(forKey: "author") as? String
        self.imageInPostsView.image = UIImage(named: post.value(forKey: "image") as? String ?? "")
        self.descriptionOfPosts.text = post.value(forKey: "desc") as? String
        self.postLikesCount.text = post.value(forKey: "likes") as? String
        self.postViewsCount.text = post.value(forKey: "views") as? String
    }
    
    //MARK: - Private methods
    
    @objc private func addLikes() {
        guard let post = post else {return}
        CoreDataManager.shared.delete(post)
        isTapped.toggle()
        let name = isTapped ? "heart.fill" : "heart"
        tapLikeButton.setImage(UIImage(systemName: name), for: .normal)
    }
    
    private func layout() {
        [nameAuthor,  postViewsCount, descriptionOfPosts, postLikesCount, likesInPosts, imageInPostsView, tapLikeButton, postViews].forEach({contentView.addSubview($0)})
        //tapLikeButton,
        
        let labelInset: CGFloat = 16
        let imageInset: CGFloat = 12
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        NSLayoutConstraint.activate([
            nameAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: labelInset),
            nameAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelInset),
            nameAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelInset),
            
            imageInPostsView.topAnchor.constraint(equalTo: nameAuthor.bottomAnchor, constant: imageInset),
            imageInPostsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageInPostsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageInPostsView.heightAnchor.constraint(equalToConstant: screenWidth),
            imageInPostsView.widthAnchor.constraint(equalToConstant: screenWidth),
            
            descriptionOfPosts.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelInset),
            descriptionOfPosts.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelInset),
            descriptionOfPosts.topAnchor.constraint(equalTo: imageInPostsView.bottomAnchor, constant: labelInset),
            
            likesInPosts.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelInset),
            likesInPosts.topAnchor.constraint(equalTo: descriptionOfPosts.bottomAnchor, constant: labelInset),
            likesInPosts.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),
            
            postLikesCount.topAnchor.constraint(equalTo: descriptionOfPosts.bottomAnchor, constant: labelInset),
            postLikesCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),
            postLikesCount.leadingAnchor.constraint(equalTo: likesInPosts.trailingAnchor),
            
            postViews.topAnchor.constraint(equalTo: descriptionOfPosts.bottomAnchor, constant: labelInset),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),
            postViews.trailingAnchor.constraint(equalTo: postViewsCount.leadingAnchor),
            
            postViewsCount.topAnchor.constraint(equalTo: descriptionOfPosts.bottomAnchor, constant: labelInset),
            postViewsCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),
            postViewsCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelInset),
            
                        tapLikeButton.topAnchor.constraint(equalTo: descriptionOfPosts.bottomAnchor, constant: labelInset),
                        tapLikeButton.leadingAnchor.constraint(equalTo: postLikesCount.trailingAnchor, constant: labelInset),
                        tapLikeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset)
        ])
    }
}

