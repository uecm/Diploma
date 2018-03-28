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
    @objc dynamic var week: Int = 1
    
    @objc dynamic var objectID: String = UUID().uuidString

    
    override static func primaryKey() -> String? {
        return "objectID"
    }
    
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        return
            lhs.subject?.name == rhs.subject?.name &&
            lhs.teacher?.fullName() == rhs.teacher?.fullName() &&
            lhs.studentGroup?.name == rhs.studentGroup?.name &&
            lhs.weekday?.name == rhs.weekday?.name &&
            lhs.week == rhs.week
    }
}
