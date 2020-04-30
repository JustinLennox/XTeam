//
//  MediaItem.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import Foundation

enum MediaType: String, Codable { case image, video }

struct MediaItem: Codable {
    let mediaType: MediaType
    let assetName: String
}
