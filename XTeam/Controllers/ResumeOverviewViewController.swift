//
//  MainViewController.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import UIKit

/// Used to show the broad overviews of a few points on my resume
class ResumeOverviewViewController: UIViewController {
    
    /// The background gradient layer for the view.
    let gradient = CAGradientLayer()
    
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    
    // MARK: Page Controller Properties
    let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var currentIndex = 0
    
    /// The array of view controllers to provide to the PageViewController
    var resumePages: [UIViewController] = []
    
    /// The array of actual data objects to be represented with each PageViewController page
    let resumeItems: [ResumeItem]
    
    // MARK: View Lifecycle
    init() {
        self.resumeItems = ResumeItem.loadFromJSON()
        super.init(nibName: nil, bundle: nil)
        for i in 0..<self.resumeItems.count {
            self.resumePages.append(TileViewController(tileDelegate: self, resumeItem: self.resumeItems[i], index: i))
        }
        self.view.backgroundColor = .white
        // I set the alphas to 0 here because I'm going to animate them in on ViewDidAppear
        self.titleLabel.alpha = 0.0
        self.detailLabel.alpha = 0.0
        self.pageController.view.alpha = 0.0
        self.setGradient()
        self.setLabels()
        self.setPageController()
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        /* We need to update the gradient's frame on viewWillLayout because you can't
         add autolayout constraints to CALayers */
        self.gradient.frame = self.view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*  I'll do a super basic animation here. Nothing fancy but better than a lame static app.
            We're going to loop through our three main views and show them all one after another.
            Instead of nesting 3 or 4 layers of UIView.animate or DispatchQueues we can just loop
            through an array of views and associated delays at which to show them */
        
        let animatingViewsAndDelays = [self.titleLabel: 0.5, self.detailLabel: 2.0, self.pageController.view: 6.0]
        for (view, delay) in animatingViewsAndDelays {
            UIView.animate(withDuration: 0.5, delay: delay, options: [], animations: {
                view?.alpha = 1.0
            })
        }

    }
    
    // MARK: View Configuration
    
    private func setLabels() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = "Hello X-Team!"
        self.titleLabel.font = UIFont.systemFont(ofSize: 40.0, weight: .heavy)
        self.titleLabel.textColor = .white
        
        self.view.addSubview(self.detailLabel)
        self.detailLabel.translatesAutoresizingMaskIntoConstraints = false
        // How do y'all spell resume? Wikipedia says résumé but that seems kind of pretentious.
        self.detailLabel.text = "My name is Justin Lennox and I've created this app as a kind of resume for you."
        self.detailLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        self.detailLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .regular)
        self.detailLabel.numberOfLines = 0
    }
    
    private func setGradient() {
        let blueColor = #colorLiteral(red: 0.09520471841, green: 0.3087737262, blue: 0.645590961, alpha: 1)
        let purpleColor = #colorLiteral(red: 0.5419072509, green: 0.3513644338, blue: 0.7027808428, alpha: 1)
        self.gradient.colors = [blueColor.cgColor, purpleColor.cgColor]
        self.view.layer.addSublayer(self.gradient)
    }
    
    private func setPageController() {
        self.pageController.view.translatesAutoresizingMaskIntoConstraints = false
        self.pageController.dataSource = self
        self.pageController.setViewControllers([self.resumePages[0]], direction: .forward, animated: true)
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)
        self.pageController.didMove(toParent: self)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            self.detailLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.detailLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            self.detailLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            
            self.pageController.view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.pageController.view.topAnchor.constraint(equalTo: self.detailLabel.bottomAnchor, constant: 40.0),
            self.pageController.view.widthAnchor.constraint(equalToConstant: 390.0),
            self.pageController.view.heightAnchor.constraint(equalToConstant: 550.0)
            
        ])
    }

}

extension ResumeOverviewViewController: UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        self.resumePages.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.resumePages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return self.resumePages.last
        }
        
        guard self.resumePages.count > previousIndex else {
            return nil
        }
        
        return self.resumePages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = self.resumePages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < self.resumePages.count else {
            return self.resumePages.first
        }
        
        guard self.resumePages.count > nextIndex else {
            return nil
        }
        
        return self.resumePages[nextIndex]
    }
}

extension ResumeOverviewViewController: TileSelectorDelegate {
    
    func tileSelected(forItem resumeItem: ResumeItem, atIndex index: Int) {
        let resumeDetailsController = ResumeDetailsViewController(resumeItem: resumeItem, index: index)
        self.navigationController?.present(resumeDetailsController, animated: true)
    }
    
}

