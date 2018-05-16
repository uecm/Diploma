//
//  SettingsViewController.swift
//  Diploma
//
//  Created by Egor on 5/6/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func logout() {
        present(UIAlertController.alert(withTitle: "Выйти",
                                message: "Вы действительно хотите выйти?",
                                actions: .ok, .cancel,
                                okCallback: { Authorizer.logout() }),
                animated: true)
    }
}

extension SettingsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableMap.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableMap[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableMap[indexPath.section][indexPath.row]
        let identifier = identifierForCell(type: item.type)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return configuredCell(cell, with: item)
    }
    

    private func identifierForCell(type: SettingItemType) -> String {
        switch type {
        case .profile:
            return "detailCell"
        case .logout:
            return "logoutCell"
        }
    }
    
    private func configuredCell<T: UITableViewCell>(_ cell: T,
                                                   with item: SettingItem) -> T {
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.detail
        return cell
    }
}



extension SettingsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tableMap[indexPath.section][indexPath.row]
        performActionForItem(with: item.type)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func performActionForItem(with type: SettingItemType) {
        switch type {
        case .profile:
            break
        case .logout:
            logout()
        }
    }
}



extension SettingsViewController {
    enum SettingItemType {
        case profile
        case logout
    }
    
    struct SettingItem {
        let type: SettingItemType
        let title: String
        let detail: String?
    }
    
    fileprivate typealias Section = [SettingItem]
    
    fileprivate var tableMap: [Section] {
        return [
            [   // general section
                SettingItem(type: .profile, title: "Пользователь", detail: DataManager.shared.currentUser?.name),
                SettingItem(type: .logout, title: "Выйти", detail: nil)
            ]
        ]
    }
}
