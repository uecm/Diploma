//
//  TeacherModel.swift
//  Diploma
//
//  Created by Egor on 5/3/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation

struct TeacherModel: Codable, Hashable {
    let id: Int
    let status: Int
    let profile: UserModel
}
