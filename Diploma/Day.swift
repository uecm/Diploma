//
//  Day.swift
//  Diploma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

class Day: Object {
    @objc dynamic var name: String?
    @objc dynamic var weekday: Int = 0
    
    convenience init(name: String?, weekday: Int) {
        self.init()
        self.name = name
        self.weekday = weekday
    }
}
