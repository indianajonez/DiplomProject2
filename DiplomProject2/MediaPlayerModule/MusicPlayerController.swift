//
//  MusicPlayerController.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

final class MusicPlayerViewController: UIViewController {
    
    //MARK: - Public properties
    
    var album: Album
    
    //MARK: - Private properties
    
    private lazy var mediaPlayer: MediaPlayer = {
        let mediaPlayer = MediaPlayer(album: album)
        mediaPlayer.translatesAutoresizingMaskIntoConstraints = false
        return mediaPlayer
    }()
    
    //MARK: - Init
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycls
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mediaPlayer.play()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mediaPlayer.stop()
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    //MARK: - Public methods
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mediaPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mediaPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mediaPlayer.topAnchor.constraint(equalTo: view.topAnchor),
            mediaPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        addBlurredView()
        view.addSubview(mediaPlayer)
        setupConstraints()
    }
    
    private func addBlurredView() {
        if UIAccessibility.isReduceTransparencyEnabled {
            self.view.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            view.addSubview(blurEffectView)
        } else {
            view.backgroundColor = UIColor.black
        }
    }
}

