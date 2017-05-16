//
//  PosterModel.swift
//  TestMEV
//
//  Created by Kirill Netavskiy on 12.05.17.
//  Copyright © 2017 Kirill Netavskiy. All rights reserved.
//

import Foundation
import RealmSwift

class PosterModel: Object {
    dynamic var title = ""
    dynamic var released = ""
    dynamic var poster = ""
    dynamic var date = Date()
    
    override static func primaryKey() -> String? {
        return "title"
    }
}
