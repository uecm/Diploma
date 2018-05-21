//
//  StudyTaskViewController.swift
//  Diploma
//
//  Created by Egor on 3/26/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class StudyTaskViewController: UITableViewController {
    
    static let segueIdentifier = "lessonInfoSegue"
    
    lazy var dataProvider: StudyTaskDataProvider = {
        return StudyTaskDataProvider()
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        title = dataProvider.task?.subject?.name
    }
    
    
    private func textForTaskStatus(_ status: StudyTask.TaskStatus) -> String {
        switch status {
        case .completed:
            return "Завершено"
        case .inProgress:
            return "В процессе"
        case .new:
            return "Новое задание"
        case .pendingReview:
            return "Ожидает проверки"
        }
    }
}

extension StudyTaskViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let task = dataProvider.task {
            configure(cell: cell, at: indexPath.row, with: task)
        }
        return cell
    }
    
    private func configure(cell: UITableViewCell, at index: Int, with task: StudyTask) {
        switch index {
        case 0:
            let type = task.subject?.type == .lecture ? "Лекция" : "Практическое занятие"
            cell.textLabel?.text = "Тип занятия"
            cell.detailTextLabel?.text = type
        case 1:
            cell.textLabel?.text = "Предмет"
            cell.detailTextLabel?.text = task.subject?.name
        case 2:
            cell.textLabel?.text = "Преподаватель"
            cell.detailTextLabel?.text = task.teacher?.fullName()
        case 3:
            cell.textLabel?.text = "Статус"
            cell.detailTextLabel?.text = textForTaskStatus(task.status)
        default:
            return
        }
    }
}

extension StudyTaskViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
