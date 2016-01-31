//
//  Playlist.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/31/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import Foundation

class Playlist {
    let name: String
    let duration: String
    let albumArtwork: String
    let recommended: Bool
    
    init(name: String, duration: String, albumArtwork: String, recommended: Bool) {
        self.recommended = recommended
        self.name = name
        self.albumArtwork = albumArtwork
        self.duration = duration
    }
}