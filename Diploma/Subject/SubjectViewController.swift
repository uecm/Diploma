//
//  SubjectViewController.swift
//  Diploma
//
//  Created by Egor on 3/26/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class SubjectViewController: UITableViewController {
    
    static let segueIdentifier = "subjectInfoSegue"
    
    lazy var dataProvider: SubjectDataProvider = {
        return SubjectDataProvider()
    }()
    
}

extension SubjectViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let subject = dataProvider.subject {
            configure(cell: cell, at: indexPath.row, with: subject)
        }
        return cell
    }
    
    private func configure(cell: UITableViewCell, at index: Int, with subject: Subject) {
        switch index {
        case 0:
            let type = subject.type == .lecture ? "Лекция" : "Практическое занятие"
            cell.textLabel?.text = "Тип занятия"
            cell.detailTextLabel?.text = type
            
        case 1:
            cell.textLabel?.text = "Название"
            cell.detailTextLabel?.text = subject.name
            
        case 2:
            cell.textLabel?.text = "Преподаватель"
        default:
            return
        }
    }
}

extension SubjectViewController {
    
}
