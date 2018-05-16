//
//  User.swift
//  Diploma
//
//  Created by Egor on 5/6/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

class User: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var email: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ model: UserModel) {
        self.init()
        self.id = model.id
        self.name = model.name
        self.email = model.email
    }
}
