//
//  Task.swift
//  Diploma
//
//  Created by Egor on 5/6/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

class StudyTask: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var text: String?
    @objc dynamic var startDate: Date?
    @objc dynamic var endDate: Date?
    
    @objc dynamic var subject: Subject?
    @objc dynamic var student: Student?
    @objc dynamic var teacher: Teacher?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ model: TaskResponseModel) {
        self.init()
        self.id = model.id
        self.text = model.description
        self.startDate = Date(timeIntervalSince1970: TimeInterval(model.startDate))
        self.endDate = Date(timeIntervalSince1970: TimeInterval(model.endDate))
        
        self.subject = Subject(model.subject)
        self.student = Student(model.student)
        self.teacher = Teacher(model.teacher)
    }
    
    
}
