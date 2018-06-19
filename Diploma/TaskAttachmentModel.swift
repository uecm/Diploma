//
//  TaskAttachment.swift
//  Diploma
//
//  Created by Egor Kisilev on 6/18/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation

struct TaskAttachmentModel: Codable, Hashable {
    let id: Int
    let taskId: Int
    let data: Data
}
