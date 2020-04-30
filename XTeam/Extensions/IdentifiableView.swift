//
//  IdentifiableView.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import UIKit

/// JL Customizable protocol that gives you a nib and class identifier to use for registering with tableviews and collectionviews
public protocol IdentifiableView {
}

public extension IdentifiableView where Self: UIViewController {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    /// A JL class identifier
    /// String(describing: self)
    static var classIdentifier: String {
        return String(describing: self)
    }
}
