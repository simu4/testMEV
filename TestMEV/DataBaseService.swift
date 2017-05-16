//
//  DataBaseService.swift
//  TestMEV
//
//  Created by Kirill Netavskiy on 14.05.17.
//  Copyright © 2017 Kirill Netavskiy. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class DataBaseService {
    
    private var realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func getMoviesFromDB() -> [PosterModel]? {
        return  Array(realm.objects(PosterModel.self).sorted(by: { (s1, s2) -> Bool in
            s1.date > s2.date
        }))
    }
    
    func addMovie(movie: PosterModel) {
        try! realm.write {
            realm.add(movie, update: true)
        }
    }
    
    func removeMovie(movie: PosterModel) {
        let movies = realm.objects(PosterModel.self).filter("title = %@", movie.title)
        try! realm.write {
            realm.delete(movies)
        }
    }
    
    func removeAllMoviesFromDB() {
        try! realm.write {
            realm.delete(getMoviesFromDB()!)
        }
    }
}
