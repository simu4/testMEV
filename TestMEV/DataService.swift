//
//  DataService.swift
//  TestMEV
//
//  Created by Kirill Netavskiy on 14.05.17.
//  Copyright © 2017 Kirill Netavskiy. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    var dbService: DataBaseService?
    var requestService: RequestService?
   
    init(dbService: DataBaseService, requestService: RequestService) {
        self.dbService = dbService
        self.requestService = requestService
    }
    
    convenience init() {
        self.init(dbService: DataBaseService(), requestService: RequestService())
    }
    
    func getMovie(title: String, completion: @escaping ((_ success: PosterModel) -> Void), failure: ((_ failure: String) -> Void)?) {
        requestService?.getMovie(title: title, completion: { movie in
            self.dbService?.addMovie(movie: movie)
            completion(movie)
        }, failure: { error in
            failure?(error)
        })
    }
    
    func getPoster(movie: PosterModel, completion: @escaping ((_ success: UIImage) -> Void)) {
        requestService?.getImage(url: movie.poster, completion: { image in
            completion(image)
        })
    }
    
    func getMoviesFromDB() -> [PosterModel]? {
        return dbService?.getMoviesFromDB()
    }
    
    func removeMovieFromList(movie: PosterModel) {
        dbService?.removeMovie(movie: movie)
 
    }
    
    func removeAllMovies() {
        dbService?.removeAllMoviesFromDB()
    }
}
