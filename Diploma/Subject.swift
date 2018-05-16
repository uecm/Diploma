//
//  Subject.swift
//  Diploma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

class Subject: Object {
    
    enum SubjectType: Int {
        case lecture
        case practice
    }
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    
    var type: SubjectType {
        get {
            return SubjectType(rawValue: subjectType) ?? .lecture
        }
        set {
            subjectType = newValue.rawValue
        }
    }
    @objc dynamic private var subjectType: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(name: String?, type: SubjectType?) {
        self.init()
        self.name = name
        self.type = type ?? .lecture
    }
    
    convenience init(_ model: SubjectModel) {
        self.init()
        self.id = model.id
        self.name = model.name
    }
    
}
