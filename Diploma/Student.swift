//
//  Student.swift
//  Diploma
//
//  Created by Egor on 5/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

class Student: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var group: String?
    @objc dynamic var name: String?
    @objc dynamic var email: String?
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ s: StudentModel) {
        self.init(
            id: s.profile.id,
            group: s.group,
            name: s.profile.name,
            email: s.profile.email
        )
    }
    
    
    convenience init(id: Int, group: String?, name: String?, email: String?) {
        self.init()
        
        self.id = id
        self.group = group
        self.name = name
        self.email = email
    }
    
    
    
}
