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
    let status: Int
}


struct TaskResponseModel: Decodable, Hashable {

    let id: Int
    let description: String
    let startDate: Double
    let endDate: Double
    let subject: SubjectModel
    let student: StudentModel
    let teacher: TeacherModel
    let status: Int
    
}
