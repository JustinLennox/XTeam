//
//  ResumeDetailViewController.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import UIKit

class ResumeDetailsViewController: UIViewController, IdentifiableView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var galleryContainer: UIView!
    
    var resumeItem: ResumeItem?
    var index: Int?
    
    init(resumeItem: ResumeItem, index: Int) {
        self.resumeItem = resumeItem
        self.index = index
        super.init(nibName: ResumeDetailsViewController.classIdentifier, bundle: nil)
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
}
