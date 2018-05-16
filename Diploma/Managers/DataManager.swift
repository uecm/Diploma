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
//        initializeTeachers()
        initializeSubjects()
        initializeGroups()
    }
    
    func dropDatabase() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    private func migrate() {
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
    }
    
    
    
    var currentUser: User? {
        return realm.objects(User.self).first
    }
    
    
    private var localStudents: [Student] {
        return Array(realm.objects(Student.self))
    }
    
    private var localTasks: [StudyTask] {
        return Array(realm.objects(StudyTask.self))
    }
    
    private var localMyTasks: [StudyTask] {
        let allTasks = localTasks
        let myTasks = allTasks.filter {
            $0.student?.id == currentUser?.id
        }
        return myTasks
    }
    
    func getStundent(for id: Int) -> Student? {
        return realm.object(ofType: Student.self, forPrimaryKey: id)
    }
    
    
    //MARK: - Repository
    
    func getMyTasks(callback: Closure<[StudyTask]>) {
        callback?(localMyTasks)
        
        APIProvider.shared.getMyTasks { (models) in
            let realmModels = models.map(StudyTask.init)
            self.update(objects: realmModels)
            callback?(realmModels)
        }
    }
    
    func getCurrentUser(callback: Closure<User?> = nil) {
        
        callback?(currentUser)
        
        APIProvider.shared.user { (userModel) in
            guard let model = userModel else {
                callback?(nil)
                return
            }
            let user = User(model)
            self.write(object: user)
            
            callback?(user)
        }
    }
    
    
    func getStudnets(callback: Closure<[Student]> = nil) {
        callback?(localStudents)
        
        APIProvider.shared.getStudents { students in
            let local = students.map(Student.init)
            self.update(objects: local)
            
            callback?(self.localStudents)
        }
    }
    
    
    // MARK: - Write
    
    func update<T>(objects: [T]) where T: Object {
        objects.forEach { write(object: $0) }
    }
    
    func write<T: Object>(object: T) {
        try! realm.write({
            realm.create(T.self, value: object, update: true)
        })
    }
}



 // MARK: - Deprecated
extension DataManager {
//    private func initializeTeachers() {
//        ["Oleksii", "Volodymyr"].forEach({
//            let teacher = Teacher(id: arc4random(), name: $0, status: .docent)
//            write(object: teacher)
//        })
//    }
    
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
}
