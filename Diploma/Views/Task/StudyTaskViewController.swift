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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "makeReport" {
            guard let reportController = segue.destination as? ReportViewController else {
                fatalError("Could not initialize ReportViewController")
            }
            reportController.dataProvider.task = dataProvider.task
        }
    }
    
}

extension StudyTaskViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let task = dataProvider.task else {
            return 0
        }
        return (task.status == .new || task.status == .inProgress) ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard dataProvider.task != nil else {
            return 0
        }
        return section == 0 ? 4 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let task = dataProvider.task {
            configure(cell: cell, at: indexPath, with: task)
        }
        return cell
    }
    
    private func configure(cell: UITableViewCell, at indexPath: IndexPath, with task: StudyTask) {
        
        // Reset to default configuration first
        cell.accessoryType = .none
        
        // Then configure to match individual style
        if indexPath.section == 0 {
            let index = indexPath.row
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
                cell.detailTextLabel?.text = StudyTask.textForTaskStatus(task.status)
            default:
                return
            }
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "Перейти к выполнению"
            cell.detailTextLabel?.text = nil
            cell.accessoryType = .disclosureIndicator
        }
    }
}

extension StudyTaskViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1, indexPath.row == 0 {
            performSegue(withIdentifier: "makeReport", sender: nil)
        }
    }
}
