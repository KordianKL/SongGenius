//
//  Parser.swift
//  Song Genius
//
//  Created by Kordian Ledzion on 31.07.2017.
//  Copyright © 2017 KordianLedzion. All rights reserved.
//

import SwiftyJSON

class Parser {

    class func parseJson(_ json: Any) -> [SongEntity] {
        let json = JSON.init(json)
        var songs = [SongEntity]()
        if json["resultCount"].int! > 0 {
            for songJSON in json["results"].array! {
                let artist = songJSON["artistName"].string!
                let name = songJSON["trackName"].string!
                let releaseDate = songJSON["releaseDate"].string!
                let strIndex = releaseDate.index(releaseDate.startIndex, offsetBy: 4)
                let releaseYear = releaseDate.substring(to: strIndex)
                let url = (songJSON["trackViewUrl"].string!).replacingOccurrences(of: "\\", with: "")
                songs.append(SongEntity(artist: artist, name: name, releaseYear: releaseYear, url: url))
            }
        }
        return songs
    }
}
