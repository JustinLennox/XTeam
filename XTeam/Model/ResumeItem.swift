//
//  ResumeItem.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import Foundation

struct ResumeItem: Codable {
    
    let title: String
    let detail: String
    
    // In real life this would probably be an asset/image URL we'd have to download,
    // but let's just keep things simple and store the images locally in xcassets.
    let imageName: String
    
    // MARK: Detailed Info
    
    let longDescription: String
    let galleryImageNames: [String]
}
