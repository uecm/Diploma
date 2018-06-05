//
//  ScheduleDataProvider.swift
//  Diploma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation
import DateToolsSwift


class SubjectsDataProvider {
    
    var subjects: [Subject] {
        return DataManager.shared.subjects
    }
    
}
