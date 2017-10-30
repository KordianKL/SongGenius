//
//  DataAccess.swift
//  Song Genius
//
//  Created by Kordian Ledzion on 14.06.2017.
//  Copyright © 2017 KordianLedzion. All rights reserved.
//

import RealmSwift

class RealmDataSource: DataSource {
    
    let dataSourceName = "Local Storage"
    private let db: Realm
    
    init() {
        self.db = try! Realm()
        getSongsFromLocal()
    }
    
    func getSongs() -> [SongEntity] {
        return db.objects(Song.self).map { $0.entity }
    }
    
    func getSongs(_ forTerm: String, completion: @escaping ((Result<[SongEntity], DataSourceError>) -> Void)) {
        let predicate = NSPredicate(format: "name CONTAINS[c] %@ OR artist CONTAINS[c] %@ OR releaseYear CONTAINS[c] %@", forTerm, forTerm, forTerm)
        let retSongs = (db.objects(Song.self).filter(predicate)).map { $0.entity } as [SongEntity]
        completion(Result.success(retSongs))
    }
    
    private func getSongsFromLocal() {
        if !db.isEmpty {
            removeAll()
        }
        
        if let path = Bundle.main.path(forResource: "songs", ofType: "csv") {
            let contents = try! String(contentsOfFile: path)
            try! db.write {
                contents.enumerateLines { (line, _) in
                    let split = line.components(separatedBy: ";")
                    let elem = Song(name: split[0], artist: split[1], releaseYear: split[2])
                    self.db.add(elem)
                }
            }
        }
    }
    
    private func removeAll() {
        try! db.write {
            db.delete(db.objects(Song.self))
        }
    }
}
