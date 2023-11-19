//
//  MediaPlayer.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit
import AVKit

final class MediaPlayer: UIView {
    
    //MARK: - Public properties
    
    var album: Album
    
    //MARK: - Private properties
    
    private lazy var albumName: UILabel = {
       let albumName = UILabel()
        albumName.translatesAutoresizingMaskIntoConstraints = false
        albumName.textAlignment = .center
        albumName.font = .systemFont(ofSize: 32, weight: .bold)
        
        return albumName
    }()
    
    private lazy var albumCoverView: UIImageView = {
       let albumCover = UIImageView()
        albumCover.translatesAutoresizingMaskIntoConstraints = false
        albumCover.contentMode = .scaleToFill
        albumCover.clipsToBounds = true
        albumCover.layer.cornerRadius = 100
        albumCover.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        return albumCover
    }()
    
    private lazy var progressBar: UISlider = {
       let progressBar = UISlider()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.addTarget(self, action: #selector(progressScrubbed(_:)), for: .valueChanged)
        progressBar.minimumTrackTintColor = UIColor(named: "subtitleColor")
        return progressBar
    }()
    
    private lazy var elapsedTimeLabel: UILabel = {
        let elapsedTimeLabel = UILabel()
        elapsedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        elapsedTimeLabel.font = .systemFont(ofSize: 14, weight: .light)
        elapsedTimeLabel.text = "00:00"
        return elapsedTimeLabel
    }()
    
    private lazy var remainingTimeLabel: UILabel = {
        let remainingTimeLabel = UILabel()
        remainingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        remainingTimeLabel.font = .systemFont(ofSize: 14, weight: .light)
        remainingTimeLabel.text = "00:00"
        return remainingTimeLabel
    }()
    
    private lazy var songNameLabel: UILabel = {
        let songNameLabel = UILabel()
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        songNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        return songNameLabel
    }()
    
    private lazy var artistLabel: UILabel = {
        let artistLabel = UILabel()
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.font = .systemFont(ofSize: 16, weight: .light)
        return artistLabel
    }()
    
    private lazy var previosButton: UIButton = {
       let previosButton = UIButton()
        previosButton.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        previosButton.setImage(UIImage(systemName: "backward.end.fill", withConfiguration: config), for: .normal)
        previosButton.addTarget(self, action: #selector(didTapPrevios(_ :)), for: .touchUpInside)
        previosButton.tintColor = .white
        return previosButton
    }()
    
    private lazy var playPlauseButton: UIButton = {
       let playPlauseButton = UIButton()
        playPlauseButton.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        playPlauseButton.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: config), for: .normal)
        playPlauseButton.addTarget(self, action: #selector(didTapPlayPause(_ :)), for: .touchUpInside)
        playPlauseButton.tintColor = .white
        return playPlauseButton
    }()
    
    private lazy var nextButton: UIButton = {
       let nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        nextButton.setImage(UIImage(systemName: "forward.end.fill", withConfiguration: config), for: .normal)
        nextButton.addTarget(self, action: #selector(didTapNext(_ :)), for: .touchUpInside)
        nextButton.tintColor = .white
        return nextButton
    }()
    
    private lazy var controlStackView: UIStackView = {
        let controlStack = UIStackView(arrangedSubviews: [previosButton, playPlauseButton, nextButton])
        controlStack.translatesAutoresizingMaskIntoConstraints = false
        controlStack.axis = .horizontal
        controlStack.distribution = .equalSpacing
        controlStack.spacing = 20
        return controlStack
    }()
    
    private var player = AVAudioPlayer()
    private var timer: Timer?
    private var playingIndex = 0
    
    //MARK: - Life cycle
    
    init(album: Album) {
        self.album = album
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func play() {
        progressBar.value = 0.0
        progressBar.maximumValue = Float(player.duration)
        player.play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    func stop() {
        player.stop()
        timer?.invalidate()
        timer = nil
    }
    
    @objc
    func updateProgress() {
        progressBar.value = Float(player.currentTime)
        
        elapsedTimeLabel.text = getFormattedTimer(timeInterval: player.currentTime)
        let remainigTime = player.duration - player.currentTime
        remainingTimeLabel.text = getFormattedTimer(timeInterval: remainigTime)
    }
    
    @objc
    func progressScrubbed(_ sender: UISlider) {
        player.currentTime = Float64(sender.value)
    }
    
    @objc
    func didTapPrevios(_ sender: UIButton) {
        playingIndex -= 1
        if playingIndex < 0 {
            playingIndex = album.songs.count - 1
        }
        setupPlayer(song: album.songs[playingIndex])
        play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    @objc
    func didTapPlayPause(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
        
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    @objc
    func didTapNext(_ sender: UIButton) {
        playingIndex += 1
        if playingIndex >= album.songs.count {
            playingIndex = 0
        }
        setupPlayer(song: album.songs[playingIndex])
        play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    
    //MARK: - Private methods
    
    private func setupView() {
        albumName.text = album.name
        albumCoverView.image = UIImage(named: album.image)
        setupPlayer(song: album.songs[playingIndex])
        
        [albumName, songNameLabel, artistLabel, elapsedTimeLabel, remainingTimeLabel].forEach { (v) in
            v.textColor = .white
        }
        
        [albumName, albumCoverView, songNameLabel, artistLabel, progressBar, elapsedTimeLabel, remainingTimeLabel, controlStackView].forEach { (v) in
            addSubview(v)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        //album name
        
        NSLayoutConstraint.activate([
        
            albumName.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumName.trailingAnchor.constraint(equalTo: trailingAnchor),
            albumName.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])
        
        // album cover
        
        NSLayoutConstraint.activate([
            albumCoverView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            albumCoverView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            albumCoverView.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 32),
            albumCoverView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.5)
        ])
        
        // song mane
        
        NSLayoutConstraint.activate([
        songNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        songNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        songNameLabel.topAnchor.constraint(equalTo: albumCoverView.bottomAnchor, constant: 16)
        ])
        
        // artistLabel
        
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            artistLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            artistLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 8)
            ])
        
        //progress bar
        
        NSLayoutConstraint.activate([
        
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            progressBar.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 8)
        
        ])
        
        // elapsed timer
        NSLayoutConstraint.activate([
        
            elapsedTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            elapsedTimeLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8)
        
        ])
        
        // remainig timer
        NSLayoutConstraint.activate([
        
            remainingTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            remainingTimeLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8)

        ])
        
        // control stack
        
        NSLayoutConstraint.activate([
        
            controlStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            controlStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            controlStackView.topAnchor.constraint(equalTo: remainingTimeLabel.bottomAnchor, constant: 8)

        ])
    }
    
    private func setupPlayer(song: Song) {
        guard let url = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else {
            return
        }
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
        
        songNameLabel.text = song.name
        artistLabel.text = song.artist
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            player.prepareToPlay()
            
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func setPlayPauseIcon(isPlaying: Bool) {
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        playPlauseButton.setImage(UIImage(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill", withConfiguration: config), for: .normal)
    }
    
    private func getFormattedTimer(timeInterval: TimeInterval) -> String {
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        guard let minsString = timeFormatter.string(from: NSNumber(value: mins)), let secStr = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "00:00"
        }
        
        return "\(minsString) : \(secStr)"
        
    }
}

//MARK: - AVAudioPlayerDelegate

extension MediaPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        didTapNext(nextButton)
    }
}
