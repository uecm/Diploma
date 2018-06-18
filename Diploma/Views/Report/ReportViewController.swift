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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.getTaskAttachments()
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
        return cell
    }
}


//MARK: UITableViewDelegate
extension ReportViewController {
    var tableMap: TableMap {
        return [
            [TableRow(title: "Результаты работы", detail: nil, accessory: .disclosureIndicator)]
        ]
    }
}
