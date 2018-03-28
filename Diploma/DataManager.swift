//
//  DataManager.swift
//  Diploma
//
//  Created by Egor on 3/27/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

class DataManager {
    static let shared = DataManager()
    lazy var realm = try! Realm()
    
    
    // MARK: - Initialization
    
    func performInitialDataConfiguration() {
        migrate()
        initializeTeachers()
        initializeSubjects()
        initializeGroups()
    }
    
    private func migrate() {
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
    }
    
    private func initializeTeachers() {
        ["Oleksii", "Volodymyr"].forEach({
            let teacher = Teacher(firstName: $0, lastName: "Teacherenko", status: .docent)
            write(object: teacher)
        })
    }
    
    private func initializeSubjects() {
        ["Programming", "Database"].forEach({
            let subject = Subject(name: $0, type: .lecture)
            write(object: subject)
        })
    }
    
    private func initializeGroups() {
        ["415", "414"].forEach({
            let group = StudentGroup(name: $0)
            write(object: group)
        })
    }
    
    
    // MARK: - Object accessors
    
    var subjects: [Subject] {
        return Array(realm.objects(Subject.self))
    }
    
    var teachers: [Teacher] {
        return Array(realm.objects(Teacher.self))
    }
    
    var groups: [StudentGroup] {
        return Array(realm.objects(StudentGroup.self))
    }
    
    var lessons: [Lesson] {
        return Array(realm.objects(Lesson.self))
    }
    
    
    // MARK: - Write
    
    func write<T>(object: T) where T: Object {
        try! realm.write({
            realm.create(T.self, value: object, update: true)
        })
    }
    
}
