//
//  TaskAttachment.swift
//  Diploma
//
//  Created by Egor Kisilev on 6/19/18.
//  Copyright © 2018 egor. All rights reserved.
//

import RealmSwift

class TaskAttachment: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var task: StudyTask?
    @objc dynamic var data: Data?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ t: TaskAttachmentModel) {
        self.init(
            id: t.id,
            taskId: t.taskId,
            data: t.data
        )
    }
    
    
    convenience init(id: Int, taskId: Int?, data: Data?) {
        self.init()
        
        self.id = id
        self.data = data
        
        if let taskId = taskId {
            self.task = DataManager.shared.task(with: taskId)
        }
    }
    
    
    
}
