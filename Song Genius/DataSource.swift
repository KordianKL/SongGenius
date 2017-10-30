//
//  DataSource.swift
//  Song Genius
//
//  Created by Kordian Ledzion on 26.07.2017.
//  Copyright © 2017 KordianLedzion. All rights reserved.
//

enum DataSourceError: Error {
    
    case connectivityProblem(description: String)
    case realmProblem(description: String)
    
    var description: String {
        return self.description
    }
}

enum Result<V, E> {
    case success(V)
    case failure(E)
}

protocol DataSource {
    
    var dataSourceName: String { get }
    
    func getSongs() -> [SongEntity]
    
    func getSongs(_ forTerm: String, completion: @escaping ((Result<[SongEntity], DataSourceError>) -> Void))
}
