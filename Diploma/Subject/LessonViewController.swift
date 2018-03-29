//
//  LessonViewController.swift
//  Diploma
//
//  Created by Egor on 3/26/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class LessonViewController: UITableViewController {
    
    static let segueIdentifier = "lessonInfoSegue"
    
    lazy var dataProvider: LessonDataProvider = {
        return LessonDataProvider()
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        title = dataProvider.lesson?.subject?.name
    }
    
}

extension LessonViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let lesson = dataProvider.lesson {
            configure(cell: cell, at: indexPath.row, with: lesson)
        }
        return cell
    }
    
    private func configure(cell: UITableViewCell, at index: Int, with lesson: Lesson) {
        switch index {
        case 0:
            let type = lesson.subject?.type == .lecture ? "Лекция" : "Практическое занятие"
            cell.textLabel?.text = "Тип занятия"
            cell.detailTextLabel?.text = type
        case 1:
            cell.textLabel?.text = "Название"
            cell.detailTextLabel?.text = lesson.subject?.name
        case 2:
            cell.textLabel?.text = "Преподаватель"
            cell.detailTextLabel?.text = lesson.teacher?.fullName()
        case 3:
            cell.textLabel?.text = "Группа"
            cell.detailTextLabel?.text = lesson.studentGroup?.name
        default:
            return
        }
    }
}

extension LessonViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
