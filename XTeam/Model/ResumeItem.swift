//
//  ResumeItem.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import Foundation

struct ResumeItem: Codable {
    
    // MARK: Overview Info
    let title: String
    let detail: String
    
    /// In real life this would probably be an asset/image URL we'd have to download,
    /// but let's just keep things simple and store the images locally in xcassets.
    let imageName: String
    
    // MARK: Detailed Info
    let longDescription: String
    let galleryAssets: [MediaItem]?
    
    /// Usually we'd probably load this kind of information from a database, along with localizations. I've created a JSON file and will load and decode it just to simulate this.
    static func loadFromJSON() -> [ResumeItem] {
        guard let path = Bundle.main.path(forResource: "ResumeItems", ofType: "json"),
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: []),
        let resumeItems = try? JSONDecoder().decode([ResumeItem].self, from: jsonData) else {
            assertionFailure("Failed to load and decode resume data from JSON.")
            return []
        }
        return resumeItems
    }
}
