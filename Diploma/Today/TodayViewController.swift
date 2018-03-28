//
//  TodayViewController.swift
//  Diploma
//
//  Created by Egor on 3/16/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class TodayViewController: UITableViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    lazy var dataProvider = TodayDataProvider()
    
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
        dateLabel.text = string(from: Date())
        statusLabel.text = "Нет новых заданий"
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func string(from date: Date) -> String {
        let dateFormat = "EEEE  MMM d  yyyy"
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date).localizedUppercase
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == SubjectViewController.segueIdentifier,
            let cell = sender as? UITableViewCell,
            let controller = segue.destination as? SubjectViewController {
            showDetailForSubject(at: cell, in: controller)
        }
    }
    
    private func showDetailForSubject(at cell: UITableViewCell, in controller: SubjectViewController) {
        guard let index = tableView.indexPath(for: cell)?.row else {
            return
        }
        let lesson = dataProvider.lessons()[index]
        controller.dataProvider.subject = lesson.subject
    }
}

//MARK: - Table View Data Source
extension TodayViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.lessons().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let lesson = dataProvider.lessons()[indexPath.row]
        
        cell.textLabel?.text = lesson.subject?.name
        cell.detailTextLabel?.text = lesson.teacher?.firstName
        
        return cell
    }
}

//MARK: - Table View Delegate
extension TodayViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
