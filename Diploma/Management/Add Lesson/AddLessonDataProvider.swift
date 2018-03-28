//
//  AddLessonDataProvider.swift
//  Diploma
//
//  Created by Egor on 3/27/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

class AddLessonDataProvider {
    
    func addLesson(_ lesson: Lesson) {
        let exists = DataManager.shared.lessons.filter({ $0 == lesson }).count == 1
        if exists == false {
            DataManager.shared.write(object: lesson)
        }
    }
    
}
