//
//  DocumentFile.swift
//  Diploma
//
//  Created by Egor on 6/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation

struct DocumentFile: Codable {
    let name: String
    let link: String
    
    var rawName: String {
        return (name as NSString).deletingLastPathComponent
    }
    
    var isPDF: Bool {
        return (name as NSString).lastPathComponent == "pdf"
    }
}
