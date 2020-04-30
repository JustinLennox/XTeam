//
//  TileViewController.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import UIKit

class TileViewController: UIViewController, IdentifiableView {
        
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var resumeItem: ResumeItem?
    var index: Int?
    weak var tileDelegate: TileSelectorDelegate?
    
    init(tileDelegate: TileSelectorDelegate, resumeItem: ResumeItem, index: Int) {
        self.resumeItem = resumeItem
        self.tileDelegate = tileDelegate
        self.index = index
        super.init(nibName: TileViewController.classIdentifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.layer.cornerRadius = 25.0
        guard let resumeItem = self.resumeItem, let index = self.index else {
            assertionFailure("Loaded a resume tile without any resume data.")
            return
        }
        self.titleLabel.text = resumeItem.title
        self.detailLabel.text = resumeItem.detail
        self.numberLabel.text = String(index + 1)
        self.imageView.image = UIImage(named: resumeItem.imageName)
    }
    
    @IBAction func learnMoreButtonPressed(_ sender: Any) {
        guard let resumeItem = self.resumeItem else {
            assertionFailure("We selected a resume tile for which there was no associated resume item.")
            return
        }
        self.tileDelegate?.tileSelected(forItem: resumeItem)
    }
    
}

protocol TileSelectorDelegate: class {
    func tileSelected(forItem resumeItem: ResumeItem)
}
