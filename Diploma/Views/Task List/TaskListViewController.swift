//
//  TaskListViewController.swift
//  Diploma
//
//  Created by Egor Kisilev on 6/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit
import DateToolsSwift

class TaskListViewController: UITableViewController {
    
    lazy var dataProvider = TaskListDataProvider()
    private var tasks: [StudyTask] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadTasks()
    }
    
    private func configureView() {
        guard let subject = dataProvider.subject else {
            return
        }
        title = subject.name
    }
    
    private func loadTasks() {
        let callback: Closure<[StudyTask]> = { [weak self] (tasks) in
            guard let strong = self else { return }
            strong.tasks = tasks
            strong.tableView.reloadData()
        }
        dataProvider.getTasks(callback: callback, update: callback)
    }
}

extension TaskListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.startDate?.format(with: .medium)
        cell.detailTextLabel?.text = StudyTask.textForTaskStatus(task.status)
        
        cell.detailTextLabel?.textColor = StudyTask.color(for: task.status)

        return cell
    }
}

extension TaskListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        let task = tasks[indexPath.row]

        if task.status == .new || task.status == .inProgress {
            performSegue(withIdentifier: "makeReport", sender: cell)
        }
    }
}
