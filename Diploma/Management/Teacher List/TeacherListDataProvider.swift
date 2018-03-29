//
//  TeacherListDataProvider.swift
//  Diploma
//
//  Created by Egor on 3/27/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation

class TeacherListDataProvider {
    
    lazy var teachers = DataManager.shared.teachers

    func lessons(for teacher: Teacher) -> [Lesson] {
        return DataManager.shared.lessons.filter({ $0.teacher?.fullName() == teacher.fullName() })
    }
}
