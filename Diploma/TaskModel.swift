//
//  TaskModel.swift
//  Diploma
//
//  Created by Egor on 5/3/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation

struct TaskRequestModel: Encodable, Hashable {
    let id: Int
    let description: String
    let startDate: Date
    let endDate: Date
    let subjectId: Int
    let studentId: Int
    let teacherId: Int
}


struct TaskResponseModel: Decodable, Hashable {
//    enum TaskResponseCodingKey: String, CodingKey {
//        case id = "id"
//        case description = "description"
//        case startDate = "startDate"
//        case endDate = "endDate"
//        case subject = "subject"
//        case student = "student"
//        case teacher = "teacher"
//    }
    
    let id: Int
    let description: String
    let startDate: Double
    let endDate: Double
    let subject: SubjectModel
    let student: StudentModel
    let teacher: TeacherModel
    
    
//    init(id: Int, description: String, startDate: Date, endDate: Date, subject: SubjectModel, student: StudentModel, teacher: TeacherModel) {
//        self.id = id
//        self.description = description
//        self.startDate = startDate
//        self.endDate = endDate
//        self.subject = subject
//        self.student = student
//        self.teacher = teacher
//    }
    
    
//    init(from decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: TaskResponseCodingKey.self)
//        let id = try container.decode(Int.self, forKey: .id)
//        let description = try container.decode(String.self, forKey: .description)
//        let startDate = try container.decode(Date.self, forKey: .startDate)
//        let endDate = try container.decode(Date.self, forKey: .endDate)
//
//
//        let subject = try container.decode(SubjectModel.self, forKey: .subject)
//        let student = try container.decode(StudentModel.self, forKey: .student)
//        let teacher = try container.decode(TeacherModel.self, forKey: .teacher)
//
//        self.init(id: id, description: description, startDate: startDate, endDate: endDate, subject: subject, student: student, teacher: teacher)
//    }
}
