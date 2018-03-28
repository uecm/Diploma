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
    
    convenience init(name: String?) {
        self.init()
        self.name = name
    }
}
