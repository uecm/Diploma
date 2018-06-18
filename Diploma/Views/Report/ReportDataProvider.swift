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
    
    func getTaskAttachments() {
        guard let task = task else { return }
        APIProvider.shared.getAttachmentsForTask(with: task.id) { (attachments) in
            print("Got task attachments: \(attachments)")
        }
    }
    
}
