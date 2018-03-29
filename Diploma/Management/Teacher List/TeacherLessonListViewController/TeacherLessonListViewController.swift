//
//  TeacherLessonListViewController.swift
//  Diploma
//
//  Created by Egor on 3/29/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class TeacherLessonListViewController: UITableViewController {
    
    var lessons: [Lesson]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
}

extension TeacherLessonListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        configureCell(cell, at: indexPath)
        return cell
    }
    
    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let lesson = lessons?[indexPath.row] {
            cell.textLabel?.text = lesson.subject?.name
            cell.detailTextLabel?.text = lesson.studentGroup?.name
        }
    }
}

extension TeacherLessonListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let lesson = lessons?[indexPath.row] {
            if let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LessonViewController") as? LessonViewController {
                destination.dataProvider.lesson = lesson
                navigationController?.show(destination, sender: self)
            }
        }
    }
}
