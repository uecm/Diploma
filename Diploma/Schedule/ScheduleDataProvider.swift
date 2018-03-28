//
//  ScheduleDataProvider.swift
//  Diploma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation
import DateToolsSwift


class ScheduleDataProvider {
    
    let dayNames = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница"]
    
    func days() -> [Day] {
//        let today = Date()
        return dayNames.enumerated().map({ (index, element) in
//            let date = Date(year: today.year, month: today.month, day: today.day - today.weekday + index + 1)
            return Day(name: element)
        })
    }
    
    
    func lessons(for day: Day) -> [Lesson] {
        return []
    }
}
