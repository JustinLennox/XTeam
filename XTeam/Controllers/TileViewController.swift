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
    weak var tileDelegate: TileSelectorDelegate?
    
    init(tileDelegate: TileSelectorDelegate) {
        super.init(nibName: "TileViewController", bundle: nil)
        self.tileDelegate = tileDelegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.layer.cornerRadius = 25.0
    }
    
    @IBAction func learnMoreButtonPressed(_ sender: Any) {
        self.tileDelegate?.tileSelected()
    }
    
}

protocol TileSelectorDelegate: class {
    func tileSelected()
}
