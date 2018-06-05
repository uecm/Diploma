//
//  TaskListDataProvider.swift
//  Diploma
//
//  Created by Egor Kisilev on 6/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation

class TaskListDataProvider {
    
    var subject: Subject?
    
    func getTasks(callback: Closure<[StudyTask]> = nil,
                  update: Closure<[StudyTask]> = nil) {
        guard let subject = subject else { fatalError("No subject was set for \(self)") }
        DataManager.shared.getMyTasks(callback: { [weak self] localTasks in
            guard let strong = self else { return }
            callback?(strong.tasks(for: subject, from: localTasks))
        }, update: { [weak self] tasks in
            guard let strong = self else { return }
            update?(strong.tasks(for: subject, from: tasks))
        })
    }
    
    private func tasks(for subject: Subject, from list: [StudyTask]) -> [StudyTask] {
        return list.filter({ $0.subject?.id == subject.id })
    }
    
}
