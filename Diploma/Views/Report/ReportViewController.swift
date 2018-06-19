//
//  ReportViewController.swift
//  Diploma
//
//  Created by Egor on 3/22/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class ReportViewController: UITableViewController {
 
    lazy var dataProvider = ReportDataProvider()
    
    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAttachments()
        commentTextView.text = dataProvider.task?.comment
        commentTextView.delegate = self
    }
    
    fileprivate func loadAttachments() {
        dataProvider.getTaskAttachments() { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAttachments" {
            let destination = segue.destination as? TaskAttachmentListViewController
            guard let attachments = dataProvider.task?.attachments else { return }
            destination?.dataProvider.attachments = Array(attachments)
            destination?.dataProvider.taskId = dataProvider.task?.id
        }
    }
    
    fileprivate func setDoneButtonHidden(_ hidden: Bool) {
        if hidden, navigationItem.rightBarButtonItem != nil {
            navigationItem.rightBarButtonItem = nil
        } else if !hidden, navigationItem.rightBarButtonItem == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endEditing))
        }
    }
    
    @objc
    fileprivate func endEditing() {
        commentTextView.endEditing(true)
    }
    
    
    @IBAction func sendToConfirmation(_ sender: Any) {
        dataProvider.sendToConfirmation() { [weak self] in
            
            if self?.navigationController?.viewControllers.first?.isKind(of: SubjectsViewController.self) == true {
                let taskList = self?.navigationController?.viewControllers.first(where: { $0.isKind(of: TaskListViewController.self) })
                self?.navigationController?.popViewController(animated: true)
                (taskList as? TaskListViewController)?.loadTasks()
            }
            else {
                let taskDetail = self?.navigationController?.viewControllers.first(where: { $0.isKind(of: StudyTaskViewController.self) })
                self?.navigationController?.popViewController(animated: true)
                (taskDetail as? UITableViewController)?.tableView.reloadData()
            }
        }
    }
}

extension ReportViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setDoneButtonHidden(false)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        setDoneButtonHidden(true)
        dataProvider.updateComment(textView.text)
    }
}


//MARK: UITableViewDataSource
extension ReportViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableMap.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableMap[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableMap[indexPath.section][indexPath.row]
        let identifier = TableRowType.identifier(for: item.type)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        
        return configureCell(cell, with: item)
    }
    
    @discardableResult
    fileprivate func configureCell(_ cell: UITableViewCell, with item: TableRow) -> UITableViewCell {
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.detail
        cell.accessoryType = item.accessoryType
        return cell
    }
}

extension ReportViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAttachments", sender: nil)
    }
}


//MARK: UITableViewDelegate
extension ReportViewController {
    var tableMap: TableMap {
        let attachmentCount = dataProvider.task?.attachments.count ?? 0
        return [
            [TableRow(title: "Результаты работы", detail: "\(attachmentCount) вложений", accessory: .disclosureIndicator)]
        ]
    }
}
