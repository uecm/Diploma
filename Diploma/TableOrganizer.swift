//
//  TableOrganizer.swift
//  Diploma
//
//  Created by Egor on 5/25/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

typealias TableSection = [TableRow]
typealias TableMap = [TableSection]

enum TableRowType {
    case plain
    case textField
    
    static func identifier(for type: TableRowType) -> String {
        switch type {
        case .plain:
            return "plainCellIdentifier"
        case .textField:
            return "textFieldCellIdentifier"
        }
    }
}

struct TableRow {
    let title: String?
    let detail: String?
    let type: TableRowType
    
    init(title: String, detail: String? = nil, type: TableRowType? = nil) {
        self.title = title
        self.detail = detail
        self.type = type ?? .plain
    }
    
}

