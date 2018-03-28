//
//  Lesson.swift
//  Diploma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

class Lesson: Object {
    @objc dynamic var subject: Subject?
    @objc dynamic var teacher: Teacher?
    @objc dynamic var studentGroup: StudentGroup?
    @objc dynamic var weekday: Day?
    
    @objc dynamic var objectID: Int = 0
//
//    static func incrementID() -> Int {
//        let realm = try! Realm()
//        return (realm.objects(Lesson.self).max(ofProperty: "objectID") as Int? ?? 0) + 1
//    }
//
    override static func primaryKey() -> String? {
        return "objectID"
    }
    
    
}
