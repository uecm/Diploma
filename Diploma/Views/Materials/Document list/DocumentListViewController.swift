//
//  DocumentListViewController
//  Diploma
//
//  Created by Egor on 6/5/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit
import PDFKit

class DocumentListViewController: UITableViewController {
    
    lazy var dataProvider = DocumentListDataProvider()
    private var files: [DocumentFile] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFiles()
    }
    
    private func getFiles() {
        dataProvider.getFiles { [weak self] (files) in
            self?.files = files
            self?.tableView.reloadData()
        }
    }
    
    private func loadFile(_ file: DocumentFile) {
        
        let pdfController = PDFViewController(nibName: "PDFViewController", bundle: nil)
    
        present(pdfController, animated: true, completion: nil)
        
        dataProvider.downloadFile(file) { (document) in
            guard let document = document else { return }
            
            let doc = PDFViewController.Document(pdf: document, name: file.name)
            pdfController.document = doc
        }
    }
}

extension DocumentListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let file = files[indexPath.row]
        
        cell.textLabel?.text = file.name
        return cell
    }
}

extension DocumentListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let file = files[indexPath.row]
        loadFile(file)
    }
}

