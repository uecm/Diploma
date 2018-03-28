//
//  StudentGroup.swift
//  Diploma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

class StudentGroup: Object {
    @objc dynamic var name: String?
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    convenience init(name: String?) {
        self.init()
        self.name = name
    }
}
