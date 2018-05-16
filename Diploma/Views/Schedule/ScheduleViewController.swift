//
//  ScheduleViewController.swift
//  Diploma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class ScheduleViewController: UITableViewController {
    
    lazy var dataProvider = ScheduleDataProvider()
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var currentWeek: Int {
        return segmentedControl.selectedSegmentIndex + 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func weekChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "lessonInfoSegue",
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) else {
                return
        }
        let day = dataProvider.days()[indexPath.section]
        let lesson = dataProvider.lessons(for: day, week: currentWeek)[indexPath.row]
        if let destination = segue.destination as? LessonViewController {
            destination.dataProvider.lesson = lesson
        }
    }
}


// MARK: - Data Source
extension ScheduleViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.dayNames.count
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        let day = dataProvider.days()[section]
        return dataProvider.lessons(for: day, week: currentWeek).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let day = dataProvider.days()[indexPath.section]
        let lesson = dataProvider.lessons(for: day, week: currentWeek)[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = lesson.subject?.name
        cell.detailTextLabel?.text = lesson.studentGroup?.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataProvider.dayNames[section]
    }
}


// MARK: - Delegate
extension ScheduleViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
