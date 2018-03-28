//
//  TodayDataProvider.swift
//  Diploma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation
import DateToolsSwift

class TodayDataProvider {
    
    func lessons() -> [Lesson] {
        let currentWeekday = Date().weekday - 1
        return DataManager.shared.lessons.filter({ $0.weekday?.weekday == currentWeekday })
    }
    
}
