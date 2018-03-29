//
//  TeacherListViewController.swift
//  Diploma
//
//  Created by Egor on 3/27/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class TeacherListViewController: UITableViewController {
    lazy var dataProvider = TeacherListDataProvider()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}


//MARK: Data Source
extension TeacherListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.teachers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let teacher = dataProvider.teachers[indexPath.row]
        cell.textLabel?.text = (teacher.firstName ?? "") + (teacher.lastName ?? "")
        cell.detailTextLabel?.text = nil
        return cell
    }
}

//MARK: Delegate
extension TeacherListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let teacher = dataProvider.teachers[indexPath.row]
        let destination = TeacherLessonListViewController(style: .grouped)
        destination.lessons = dataProvider.lessons(for: teacher)
        
        navigationController?.show(destination, sender: self)
    }
    
}
