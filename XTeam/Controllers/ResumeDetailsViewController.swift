//
//  ResumeDetailViewController.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import UIKit

/// Used to show the detailed information of a specific item on my resume
class ResumeDetailsViewController: UIViewController, IdentifiableView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var galleryContainer: UIView!

    var resumeItem: ResumeItem?
    
    // MARK: Page Controller Properties
    let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var mediaControllers: [UIViewController] = []
    var index: Int?
    
    // MARK: View Lifecycle
    
    init(resumeItem: ResumeItem, index: Int) {
        self.resumeItem = resumeItem
        self.index = index
        super.init(nibName: ResumeDetailsViewController.classIdentifier, bundle: nil)
        self.configurePageViewController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.showsVerticalScrollIndicator = false

        guard let resumeItem = self.resumeItem, let index = self.index else {
            assertionFailure("Tried to load a resume details view controller without resume data.")
            return
        }
        self.numberLabel.text = String(index + 1)
        self.imageView.image = UIImage(named: resumeItem.imageName)
        self.titleLabel.text = resumeItem.title
        self.detailLabel.text = resumeItem.detail
        self.longDescriptionLabel.text = resumeItem.longDescription
    }
    
    // MARK: View Configuration
    
    func configurePageViewController() {
        guard let galleryAssets = self.resumeItem?.galleryAssets else {
            print("No gallery items for this particular resume item.")
            self.pageController.view.isHidden = true
            return
        }
        for galleryAsset in galleryAssets
        {
            if let mediaController = MediaViewController(mediaItem: galleryAsset) {
                self.mediaControllers.append(mediaController)
            }
        }
        if let firstMediaController = self.mediaControllers.first {
            self.pageController.setViewControllers([firstMediaController], direction: .forward, animated: true)
        }
        self.pageController.dataSource = self
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)
        self.pageController.didMove(toParent: self)
        self.pageController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pageController.view.leadingAnchor.constraint(equalTo: self.galleryContainer.leadingAnchor),
            self.pageController.view.trailingAnchor.constraint(equalTo: self.galleryContainer.trailingAnchor),
            self.pageController.view.topAnchor.constraint(equalTo: self.galleryContainer.topAnchor),
            self.pageController.view.bottomAnchor.constraint(equalTo: self.galleryContainer.bottomAnchor)
        ])
        
        self.galleryContainer.layer.cornerRadius = 15.0
    }
}

extension ResumeDetailsViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        self.resumeItem?.galleryAssets?.count ?? 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.mediaControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return self.mediaControllers.last
        }
        
        guard self.mediaControllers.count > previousIndex else {
            return nil
        }
        
        return self.mediaControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = self.mediaControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < self.mediaControllers.count else {
            return self.mediaControllers.first
        }
        
        guard self.mediaControllers.count > nextIndex else {
            return nil
        }
        
        return self.mediaControllers[nextIndex]
    }
}

