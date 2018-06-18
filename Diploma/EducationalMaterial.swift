//
//  EducationalMaterial.swift
//  Diploma
//
//  Created by Egor on 6/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation

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
    
    static func forIndex(_ index: Int) -> EducationalMaterial? {
        switch index {
        case 0:
            return .book
        case 1:
            return .guidelines
        case 2:
            return .lab
        default:
            return nil
        }
    }
}
