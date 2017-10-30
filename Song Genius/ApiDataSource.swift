//
//  ApiDataSource.swift
//  Song Genius
//
//  Created by Kordian Ledzion on 31.07.2017.
//  Copyright © 2017 KordianLedzion. All rights reserved.
//

class ApiDataSource: DataSource {
    
    let dataSourceName = "iTunes"
    
    func getSongs(_ forTerm: String, completion: @escaping ((Result<[SongEntity], DataSourceError>) -> Void)) {
        _ = API.request(.getSongs(forTerm: forTerm)) { result in
            switch result {
            case .success(let json):
                completion(Result.success(Parser.parseJson(json)))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    //empty array for updating tableView, no songs cause it's not possible to fetch ALL songs from iTunes
    func getSongs() -> [SongEntity] {
        return [SongEntity]()
    }
}
