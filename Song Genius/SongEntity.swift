//
//  SongEntity.swift
//  Song Genius
//
//  Created by Kordian Ledzion on 26.07.2017.
//  Copyright © 2017 KordianLedzion. All rights reserved.
//

struct SongEntity {
    
    let artist: String
    let name: String
    let releaseYear: String
    let primaryKey: String
    let url: String
    
    init(artist: String, name: String, releaseYear: String, url: String = "") {
        self.artist = artist;
        self.name = name
        self.releaseYear = releaseYear
        self.primaryKey = "\(self.name) by \(self.artist)"
        self.url = url
    }
}
