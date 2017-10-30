//
//  API.swift
//  Song Genius
//
//  Created by Kordian Ledzion on 15.06.2017.
//  Copyright © 2017 KordianLedzion. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint {
    case getSongs(forTerm: String)
    
    var url: String {
        switch self {
        case .getSongs(let forTerm):
            return forTerm.replacingOccurrences(of: " ", with: "+")
        }
    }
    
    //We'll be covering only one HTTP method but WHO KNOWS?! growth potential for the win
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getSongs:
            return .get
        }
    }
}

final class API {
    // country = pl    because we're in Poland and we want Polish market
    // limit = 50     seems reasonable
    // media = music   we obviously want music only (not musicVideos, software etc)
    // entity = song   we want songs returned (not albums, artist only etc)
    // term = ??       user's input here (with & removed and spaces changed to "&"
    
    static func request(_ endpoint: Endpoint, completion: @escaping ((Result<Any, DataSourceError>) -> Void)) -> DataRequest {
        let url = URL(string: "https://itunes.apple.com/search?country=pl&limit=50&entity=song&media=music&term=\(endpoint.url)")!
        switch endpoint {
        case .getSongs:
            let request = Alamofire.request(url, method: endpoint.method)
            request.responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(Result.success(value))
                    
                case .failure(let error):
                    completion(Result.failure(DataSourceError.connectivityProblem(description: error.localizedDescription)))
                }
            }
            return request
        }
    }
    
}




//Maybe RxSwift will be fixed one day 😅

//extension API: ReactiveCompatible {}
//
//extension Reactive where Base: API {
//    func request(_ endpoint: Endpoint) -> Observable<[Song]> {
//        return Observable.create { observer in
//            let request = API.request( endpoint, completion: { success, songs in
//                if(success) {
//                    observer.onNext(songs!)
//                } else {
//                    observer.onNext([Song]())
//                }
//            })
//            return Disposables.create {
//                request.cancel()
//            }
//            }.observeOn(MainScheduler.instance)
//    }
//}
