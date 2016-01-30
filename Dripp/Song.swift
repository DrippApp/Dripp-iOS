//
//  Song.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import Foundation

class Song {
    let id: Int
    let name: String
    let duration: Int
    let albumArtwork: String
    let file: String
    let album: String
    
    init(name: String, albumArtwork: String, id: Int, duration: Int, file: String, album: String) {
        self.id = id
        self.name = name
        self.albumArtwork = albumArtwork
        self.file = file
        self.duration = duration
        self.album = album
    }
}