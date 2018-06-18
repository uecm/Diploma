//
//  PDFViewController.swift
//  Diploma
//
//  Created by Egor Kisilev on 6/18/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit
import PDFKit

final class PDFViewController: UIViewController {
   
    typealias Document = (pdf: PDFDocument?, name: String?)
    
    @IBOutlet private weak var pdfView: PDFView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var document: Document? {
        didSet { updateView(for: document) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPDFView()
    }
    
    private func setupPDFView() {
        pdfView.autoScales = true
    }
    
    func updateView(for document: Document?) {
        loadViewIfNeeded()
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }
        pdfView.document = document?.pdf
        navigationBar.topItem?.title = document?.name
    }
    
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
