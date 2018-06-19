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

    func task(with id: Int) -> StudyTask? {
        return realm.object(ofType: StudyTask.self, forPrimaryKey: id)
    }
    
    func getStundent(for id: Int) -> Student? {
        return realm.object(ofType: Student.self, forPrimaryKey: id)
    }
    
    @discardableResult
    func addAttachments(_ attachments: [TaskAttachment], to task: StudyTask) -> StudyTask {
        try! realm.write {
            for attachment in attachments {
                if !task.attachments.contains(attachment) {
                    task.attachments.append(attachment)
                }
            }
        }
        return task
    }
    
    @discardableResult
    func updateComment(_ comment: String, in task: StudyTask) -> StudyTask {
        try! realm.write {
            task.comment = comment
        }
        return task
    }
    
    func updateTaskStatus(_ task: StudyTask, status: StudyTask.TaskStatus) {
        try! realm.write {
            task.status = status
        }
    }
    
    //MARK: - Repository
    
    func getMyTasks(callback: Closure<[StudyTask]>, update: Closure<[StudyTask]> = nil) {
        callback?(localMyTasks)
        
        APIProvider.shared.getMyTasks { [unowned self] (models) in
            let realmModels = models.map(StudyTask.init)
            self.update(objects: realmModels)
            update?(self.localMyTasks)
        }
    }
    
    func getCurrentUser(callback: Closure<User?> = nil, update: Closure<User?> = nil) {
        
        callback?(currentUser)
        
        APIProvider.shared.user { (userModel) in
            guard let model = userModel else {
                callback?(nil)
                return
            }
            let user = User(model)
            self.write(object: user)
            
            update?(user)
        }
    }
    
    
    func getStudnets(callback: Closure<[Student]> = nil, update: Closure<[Student]> = nil) {
        callback?(localStudents)
        
        APIProvider.shared.getStudents { students in
            let local = students.map(Student.init)
            self.update(objects: local)
            
            callback?(self.localStudents)
        }
    }
    
    
    // MARK: - Write
    
    @discardableResult
    func update<T: Object>(objects: [T]) -> [T] {
        let updated = objects.map { write(object: $0) }
        return updated
    }
    
    @discardableResult
    func write<T: Object>(object: T) -> T {
        var obj: T?
        try! realm.write({
            obj = realm.create(T.self, value: object, update: true)
        })
        return obj!
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
