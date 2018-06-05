//
//  MaterialsViewController.swift
//  Diploma
//
//  Created by Egor Kisilev on 6/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

enum EducationalMaterial {
    case book
    case guidelines
    case lab
    
    static let all: [EducationalMaterial] = [.book, .guidelines, .lab]
    
    var name: String {
        switch self {
        case .book:
            return "Книги"
        case .guidelines:
            return "Методичные указания"
        case .lab:
            return "Лабораторные работы"
        }
    }
}

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
    
}
