//
//  ResumeDetailViewController.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import UIKit

class ResumeDetailsViewController: UIViewController, IdentifiableView {
    
    init(resumeItem: ResumeItem) {
        super.init(nibName: ResumeDetailsViewController.classIdentifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
