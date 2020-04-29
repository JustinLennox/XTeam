//
//  TileView.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import UIKit

class TileView: UIView, IdentifiableView {

    @IBOutlet var contentView: UIView!
//    @IBOutlet weak var containerView: UIView!
//    @IBOutlet weak var numberLabel: UILabel!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var detailLabel: UILabel!
//    @IBOutlet weak var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    func configure() {
//        Bundle.main.loadNibNamed("TileView", owner: self, options: nil)
//        self.addSubview(self.contentView)
//        tileView.containerView.layer.cornerRadius = 12.0
        
    }
    
    @IBAction func learnMorePressed(_ sender: Any) {
    }
}
