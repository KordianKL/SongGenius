//
//  Song.swift
//  Song Genius
//
//  Created by Kordian Ledzion on 14.06.2017.
//  Copyright © 2017 KordianLedzion. All rights reserved.
//

import RealmSwift

class Song: Object {
    
    dynamic var name: String = ""
    dynamic var artist: String = ""
    dynamic var releaseYear: String = ""
    dynamic var primaryKey: String = ""
    dynamic var url: String = ""
    
    convenience init(name: String, artist: String, releaseYear: String, url: String = "") {
        self.init()
        self.name = name
        self.artist = artist
        self.releaseYear = releaseYear
        self.primaryKey = "\(self.name) by \(self.artist)"
        self.url = url
    }
    
    convenience init(songEntity: SongEntity) {
        self.init()
        self.name = songEntity.name
        self.artist = songEntity.artist
        self.releaseYear = songEntity.releaseYear
        self.primaryKey = songEntity.primaryKey
        self.url = songEntity.url
    }
    
    var entity: SongEntity {
        return SongEntity(artist: self.artist, name: self.name, releaseYear: self.releaseYear, url: self.url)
    }
}
