//
//  ReportDataProvider.swift
//  Diploma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation

class ReportDataProvider {
    
    var task: StudyTask?
    
    func getTaskAttachments(completion: Callback) {
        guard let task = task else { return }
        if task.attachments.count > 0 {
            completion?()
        }
        APIProvider.shared.getAttachmentsForTask(with: task.id) { [weak self] (attachments) in
            
            guard let strongSelf = self else { return }
            let attachments = attachments.map(TaskAttachment.init)
            let stored = DataManager.shared.update(objects: attachments)
            strongSelf.task = DataManager.shared.addAttachments(stored, to: task)
        
            completion?()
        }
    }
    
    func updateComment(_ comment: String?) {
        guard
            let task = task,
            let comment = comment,
            comment != task.comment else { return }
        APIProvider.shared.updateCommentForTask(with: task.id, comment: comment) { [weak self] success in
            guard success else { return }
            let task = DataManager.shared.updateComment(comment, in: task)
            self?.task = task
        }
    }
    
    func sendToConfirmation(completion: Callback = nil) {
        guard let task = task else { return }
        DataManager.shared.updateTaskStatus(task, status: .pendingReview)
        completion?()
    }
}
