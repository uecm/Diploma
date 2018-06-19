//
//  TaskAttachmentListViewController.swift
//  Diploma
//
//  Created by Egor Kisilev on 6/19/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit
import Lightbox


class TaskAttachmentListViewController: UITableViewController {
    
    lazy var dataProvider = TaskAttachmentListDataProvider()
    
    @IBAction func addAttachment(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Выберите вложение", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: { (_) in
            self.addAttachment(from: .camera)
        }))
        actionSheet.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { (_) in
            self.addAttachment(from: .photoLibrary)
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func addAttachment(from source: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = source
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    fileprivate func uploadAttachment(_ attachment: UIImage) {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.center = navigationController?.view.center ?? view.center
        view.addSubview(activity)
        activity.startAnimating()
        
        dataProvider.addAttachment(attachment) { [weak self] success in
            activity.removeFromSuperview()
            self?.tableView.reloadData()
        }
    }
}

extension TaskAttachmentListViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        picker.dismiss(animated: true) {
            self.uploadAttachment(chosenImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension TaskAttachmentListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.attachments?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let attachment = dataProvider.attachments?[indexPath.row] else { return cell }
        cell.textLabel?.text = "Attachment #\(indexPath.row + 1)"
        if let data = attachment.data, let image = UIImage(data: data) {
            cell.imageView?.image = image
        }
        return cell
    }
}

extension TaskAttachmentListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let attachment = dataProvider.attachments?[indexPath.row],
            let data = attachment.data,
            let image = UIImage(data: data) else { return }
        
        let lightboxImage = LightboxImage(image: image)
        
        let imageViewer = LightboxController(images: [lightboxImage], startIndex: 0)
        imageViewer.dynamicBackground = true

        present(imageViewer, animated: false, completion: nil)
    }
}
