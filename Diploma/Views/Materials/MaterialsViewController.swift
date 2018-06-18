//
//  MaterialsViewController.swift
//  Diploma
//
//  Created by Egor Kisilev on 6/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit



class MaterialsViewController: UITableViewController {
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EducationalMaterial.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let type = EducationalMaterial.all[indexPath.row]
        
        cell.textLabel?.text = type.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let cell = sender as? UITableViewCell,
            let index = tableView.indexPath(for: cell)?.row else {
                return
        }
        let dataProvider = (segue.destination as? DocumentListViewController)?.dataProvider
        let materialType = EducationalMaterial.forIndex(index)
        dataProvider?.materialType = materialType ?? .book
    }
}

