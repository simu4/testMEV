//
//  RequestService.swift
//  TestMEV
//
//  Created by Kirill Netavskiy on 12.05.17.
//  Copyright © 2017 Kirill Netavskiy. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class RequestService {
    let baseUrl = "https://www.omdbapi.com/?t="
    
    func getData(title: String, completion: @escaping ((_ success: Any) -> Void), failure: ((_ failure: Error) -> Void)?) {
        let url = baseUrl + title
        request(url).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                failure?(error)
            }
        })
    }
    
    func getImage(url: String, completion: @escaping ((_ success: UIImage) -> Void)) {
        request(url).responseImage {  response in
                guard let image = response.result.value else { return }
                completion(image)
            }
    }
    
    func getMovie(title: String, completion: @escaping ((_ success: PosterModel) -> Void), failure: ((_ failure: String) -> Void)?) {
        getData(title: title, completion: { (data) in
            if let json = data as? [String:Any] {
                let movie = PosterModel()
                if json["Response"] as! String == "True" {
                    movie.poster = json["Poster"]! as! String
                    movie.released = json["Released"]! as! String
                    movie.title = json["Title"]! as! String
                    completion(movie)
                } else {
                    failure?(json["Error"] as! String)
                }
            }
        }, failure: nil)
    }
    
}
