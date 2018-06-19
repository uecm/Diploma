//
//  TaskAttachmentListDataProvider.swift
//  Diploma
//
//  Created by Egor Kisilev on 6/19/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class TaskAttachmentListDataProvider {
    var taskId: Int?
    var attachments: [TaskAttachment]?
    
    func addAttachment(_ attachment: UIImage, completion: Closure<Bool>) {
        guard let taskId = taskId, let data = UIImageJPEGRepresentation(attachment, 0.5) else {
            completion?(false)
            return
        }
        APIProvider.shared.uploadAttachment(data, forTaskWithId: taskId) { [weak self] attachmentId in
            if let id = attachmentId {
                let attachment = TaskAttachment(id: id, taskId: taskId, data: data)
                
                if let task = DataManager.shared.task(with: taskId) {
                    let updated = DataManager.shared.addAttachments([attachment], to: task)
                    self?.attachments = Array(updated.attachments)
                }
            }
            completion?(attachmentId != nil)
        }
    }
}
