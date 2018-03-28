//
//  Teacher.swift
//  Di🅱️loma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

class Teacher: Object {
    
    enum TeacherStatus: Int {
        case assistant
        case teacher
        case professor
        case docent
        case PhD
    }
    
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    var status: TeacherStatus? {
        get {
            return TeacherStatus(rawValue: privateStatus) ?? .assistant
        }
        set {
            privateStatus = newValue?.rawValue ?? 0
        }
    }
    @objc dynamic var privateStatus: Int = 0
    
    
    override static func primaryKey() -> String? {
        return "firstName"
    }
    
    
    convenience init(firstName: String?, lastName: String?, status: TeacherStatus) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
        self.status = status
    }
    
    func fullName() -> String {
        return (firstName ?? "") + (firstName != nil ? " " : "") + (lastName ?? "")
    }
    
}
