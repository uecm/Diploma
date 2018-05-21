//
//  TodayViewController.swift
//  Diploma
//
//  Created by Egor on 3/16/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class TodayViewController: UITableViewController {
    enum ListType: Int {
        case finished
        case current
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var taskSegmentedControl: UISegmentedControl!
    
    private var listType: ListType {
        return ListType(rawValue: taskSegmentedControl.selectedSegmentIndex)!
    }
    
    lazy var dataProvider = TodayDataProvider()
    private var tasks: [StudyTask] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сегодня"
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureView() {
        loadTasks()

        dateLabel.text = string(from: Date())
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func loadTasks() {
        let updateClosure: ([StudyTask]) -> Void = { (tasks) in
            self.tasks = tasks
            self.tableView.reloadData()
            self.updateStatusLabel()
        }
        if listType == .current {
            dataProvider.pendingTasks(callback: updateClosure, update: updateClosure)
        } else {
            dataProvider.finishedTasks(callback: updateClosure, update: updateClosure)
        }
    }
    
    private func updateStatusLabel() {
        if tasks.count > 0 {
            self.statusLabel.text = "\(listType == .finished ? "В" : "Нев")ыполненных заданий: \(tasks.count)"
        } else {
            self.statusLabel.text = "Нет \(listType == .finished ? "" : "не")выполненных заданий"
        }
    }
    
    private func string(from date: Date) -> String {
        let dateFormat = "EEEE  MMM d  yyyy"
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date).localizedUppercase
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == StudyTaskViewController.segueIdentifier,
            let cell = sender as? UITableViewCell,
            let controller = segue.destination as? StudyTaskViewController {
            showDetailForSubject(at: cell, in: controller)
        }
    }
    
    private func showDetailForSubject(at cell: UITableViewCell, in controller: StudyTaskViewController) {
        guard let index = tableView.indexPath(for: cell)?.row else {
            return
        }
        let task = tasks[index]
        controller.dataProvider.task = task
    }
    
    @IBAction func changeListType(_ sender: Any) {
        loadTasks()
    }
}

//MARK: - Table View Data Source
extension TodayViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.subject?.name
        cell.detailTextLabel?.text = task.endDate?.format(with: .medium)
        
        return cell
    }
}

//MARK: - Table View Delegate
extension TodayViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
