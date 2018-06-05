//
//  SubjectsViewController.swift
//  Diploma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class SubjectsViewController: UITableViewController {
    
    lazy var dataProvider = SubjectsDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Предметы"
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
            segue.identifier == "showTaskList",
            let cell = sender as? UITableViewCell,
            let index = tableView.indexPath(for: cell)?.row else {
                return
        }
        let subject = dataProvider.subjects[index]
        (segue.destination as? TaskListViewController)?.dataProvider.subject = subject
    }
}


// MARK: - Data Source
extension SubjectsViewController {
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return dataProvider.subjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let subject = dataProvider.subjects[index]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = subject.name
        cell.detailTextLabel?.text = nil
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}


// MARK: - Delegate
extension SubjectsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
