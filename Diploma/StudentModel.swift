//
//  StudentModel.swift
//  Diploma
//
//  Created by Egor on 5/3/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation

struct StudentModel: Codable, Hashable {
    let id: Int
    let group: String
    let profile: UserModel
}
