//
//  SongsViewModel.swift
//  Song Genius
//
//  Created by Kordian Ledzion on 01.08.2017.
//  Copyright ÂŠ 2017 KordianLedzion. All rights reserved.
//

class SongsViewModel {
    
    var songs = [SongEntity]()
    var navigationItemTitle: String
    var currentSorting = SortOptions() {
        didSet {
            sort()
        }
    }
    private let realmManager = RealmDataSource()
    private let apiManager = ApiDataSource()
    private var currentManager: DataSource!
    
    init() {
        currentManager = realmManager
        songs = currentManager.getSongs()
        navigationItemTitle = currentManager.dataSourceName
    }
    
    private func sort() {
        if currentSorting.sortingOrder == .ascending {
            switch currentSorting.sortingBy {
            case .byArtist:
                songs.sort {
                    $0.artist < $1.artist
                }
            case .byName:
                songs.sort {
                    $0.name < $1.name
                }
            case .byYear:
                songs.sort {
                    $0.releaseYear < $1.releaseYear
                }
            }
        } else {
            switch currentSorting.sortingBy {
            case .byArtist:
                songs.sort {
                    $0.artist > $1.artist
                }
            case .byName:
                songs.sort {
                    $0.name > $1.name
                }
            case .byYear:
                songs.sort {
                    $0.releaseYear > $1.releaseYear
                }
            }
        }
    }
    
    func searchFor(_ searchText: String, completion: @escaping ((Result<Void, String>) -> Void)) {
        currentManager.getSongs(searchText) { result in
            switch result {
            case .success(let songs):
                self.songs = songs
                completion(Result.success())
            case .failure(let error):
                completion(Result.failure(error.description))
            }
        }
    }
    
    func switchDataSource(_ isOn: Bool) {
        if isOn {
            songs.removeAll()
            currentManager = apiManager
        } else {
            currentManager = realmManager
        }
        navigationItemTitle = currentManager.dataSourceName
        songs = currentManager.getSongs()
    }
}

struct SortOptions {
    
    var sortingBy = Sorting.byArtist
    var sortingOrder = SortingOrder.ascending
}
