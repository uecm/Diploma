//
//  DocumentListDataProvider.swift
//  Diploma
//
//  Created by Egor on 6/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation
import PDFKit

class DocumentListDataProvider {
    
    var materialType: EducationalMaterial = .book
    private var books: [DocumentFile] = []
    
    
    func getFiles(_ completion: Closure<[DocumentFile]>) {
        switch materialType {
        case .book:
            getBooks(completion)
        default:
            return print("💯 💯 💯 NOT IMPLEMENTED YET")
        }
    }
    
    func downloadFile(_ file: DocumentFile, completion: Closure<PDFDocument?>) {
        switch materialType {
        case .book:
            downloadBook(file, completion: completion)
        default:
            return print("💯 💯 💯 NOT IMPLEMENTED YET")
        }
    }
    
    private func getBooks(_ completion: Closure<[DocumentFile]>) {
        if !books.isEmpty {
            completion?(books)
        }
        APIProvider.shared.getBooks { [weak self] (books) in
            self?.books = books
            completion?(books)
        }
    }
    
    private func downloadBook(_ book: DocumentFile, completion: Closure<PDFDocument?>) {
        APIProvider.shared.downloadBook(book) { (data) in
            guard let data = data else { return }
            completion?(PDFDocument(data: data))
        }
    }
    
}
