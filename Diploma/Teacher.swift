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
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    
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
        return "id"
    }
    
    convenience init(_ model: TeacherModel) {
        self.init(
            id: model.id,
            name: model.profile.name,
            status: TeacherStatus(rawValue: model.status) ?? .teacher
        )
    }
    
    convenience init(id: Int, name: String?, status: TeacherStatus) {
        self.init()
        self.id = id
        self.name = name
        self.status = status
    }
    
    func fullName() -> String {
        return name ?? ""
    }
    
}
