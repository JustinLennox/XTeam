//
//  MediaViewController.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

/// Displays either an image or a video
class MediaViewController: UIViewController {
    
    let mediaItem: MediaItem
    
    // An ImageView to use if the media is an image
    let imageView: UIImageView?
    
    // An AVPlayer and Controller if the media is a video
    let avPlayer: AVPlayer?
    let avPlayerController: AVPlayerViewController?
    
    /// Just to be cool I've made this an optional initializer that fails if we can't load the
    /// associated media. That's pretty robust.
    init?(mediaItem: MediaItem) {
        self.mediaItem = mediaItem
        switch self.mediaItem.mediaType {
        case .image:
            // We don't need video objects if we're only showing a photo and vice-versa
            self.avPlayer = nil
            self.avPlayerController = nil
            guard let image = UIImage(named: mediaItem.assetName) else {
                assertionFailure("Failed to load image media item named \(mediaItem.assetName)")
                return nil
            }
            self.imageView = UIImageView(image: image)
        case .video:
            self.imageView = nil
            guard let path = Bundle.main.path(forResource: mediaItem.assetName, ofType:"mp4") else {
                assertionFailure("Failed to load video media item named \(mediaItem.assetName)")
                return nil
            }
            self.avPlayer = AVPlayer(url: URL(fileURLWithPath: path))
            self.avPlayerController = AVPlayerViewController()
            self.avPlayerController?.player = self.avPlayer
            self.avPlayerController?.showsPlaybackControls = false
        }
        super.init(nibName: nil, bundle: nil)
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        self.avPlayer?.play()
    }

    func layoutViews() {
        if let imageView = self.imageView {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.layer.masksToBounds = true
            self.view.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
        
        if let playerController = self.avPlayerController {
            self.addChild(playerController)
            self.view.addSubview(playerController.view)
            playerController.didMove(toParent: self)
            playerController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                playerController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                playerController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                playerController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                playerController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
    }

}
