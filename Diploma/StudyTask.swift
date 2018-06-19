//
//  Task.swift
//  Diploma
//
//  Created by Egor on 5/6/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

final class StudyTask: Object {
    enum TaskStatus: Int {
        case new = 0
        case inProgress = 1
        case pendingReview = 2
        case completed = 3
    }
    
    @objc dynamic var id: Int = 0
    @objc dynamic var text: String?
    @objc dynamic var startDate: Date?
    @objc dynamic var endDate: Date?
    @objc dynamic var comment: String?
    
    let attachments = List<TaskAttachment>()
    
    
    var status: TaskStatus {
        get { return TaskStatus(rawValue: statusPrivate) ?? .new }
        set { statusPrivate = newValue.rawValue }
    }
    @objc private dynamic var statusPrivate: Int = TaskStatus.new.rawValue
    
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
        self.statusPrivate = model.status
        self.comment = model.comment
        
        self.subject = Subject(model.subject)
        self.student = Student(model.student)
        self.teacher = Teacher(model.teacher)
        
        let attachments = model.attachments.map(TaskAttachment.init)
        self.attachments.append(objectsIn: attachments)
    }
    
    static func textForTaskStatus(_ status: StudyTask.TaskStatus) -> String {
        switch status {
        case .completed:
            return "Завершено"
        case .inProgress:
            return "В процессе"
        case .new:
            return "Новое задание"
        case .pendingReview:
            return "Ожидает проверки"
        }
    }
    
    static func color(for status: StudyTask.TaskStatus) -> UIColor {
        switch status {
        case .completed:
            return #colorLiteral(red: 0.2039215686, green: 0.8549019608, blue: 0.431372549, alpha: 1)
        case .inProgress:
            return #colorLiteral(red: 0, green: 0.4901960784, blue: 0.9803921569, alpha: 1)
        case .new:
            return #colorLiteral(red: 0.2705882353, green: 0.7882352941, blue: 0.968627451, alpha: 1)
        case .pendingReview:
            return #colorLiteral(red: 1, green: 0.5725490196, blue: 0.1490196078, alpha: 1)
        }
    }
}
