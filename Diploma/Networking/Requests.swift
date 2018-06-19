//
//  Requests.swift
//  Diploma
//
//  Created by Egor on 5/4/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation

//MARK: - User
extension APIProvider {

    func login(email: String, password: String, completion: Closure<String?>) {
        request(.login(email: email, password: password)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let token = try response.mapString(atKeyPath: "token")
                    completion?(token)
                } catch {
                    print("Could not parse response in function \(#function)")
                    completion?(nil)
                }
            case let .failure(error):
                debugPrint("An error occurred while trying to login: " +
                "\(error.localizedDescription)")
                completion?(nil)
            }
        }
    }
    
    
    func user(completion: Closure<UserModel?>) {
        request(.user) { (result) in
            switch result {
            case let .success(response):
                do {
                    let user = try response.map(UserModel.self)
                    completion?(user)
                } catch {
                    print("Could not parse user in function \(#function)")
                    completion?(nil)
                }
            case let .failure(error):
                debugPrint("An error occurred while trying to get current user: " +
                    "\(error.localizedDescription)")
                completion?(nil)
            }
        }
    }
}


//MARK: - Tasks
extension APIProvider {

    func getMyTasks(_ completion: Closure<[TaskResponseModel]>) {
        request(.myTasks) { (result) in
            switch result {
            case let .success(response):
                do {
                    let tasks = try response.map([TaskResponseModel].self)
                    completion?(tasks)
                } catch {
                    print("Could not parse tasks in function \(#function)")
                    completion?([])
                }
            case let .failure(error):
                debugPrint("An error occurred while trying to get current user: " +
                    "\(error.localizedDescription)")
                completion?([])
            }
        }
    }
    
    func getAllTasks(_ completion: Closure<[TaskResponseModel]>) {
        request(.allTasks) { (result) in
            switch result {
            case let .success(response):
                do {
                    let tasks = try response.map([TaskResponseModel].self)
                    completion?(tasks)
                } catch {
                    print("Could not parse tasks in function \(#function)")
                    completion?([])
                }
            case let .failure(error):
                debugPrint("An error occurred while trying to get current user: " +
                    "\(error.localizedDescription)")
                completion?([])
            }
        }
    }
    
    func getAttachmentsForTask(with id: Int, completion: Closure<[TaskAttachmentModel]>) {
        request(.taskAttachments(taskId: id)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let attachments = try response.map([TaskAttachmentModel].self)
                    completion?(attachments)
                } catch {
                    print("Could not parse task attachments in function \(#function)")
                    completion?([])
                }
            case let .failure(error):
                debugPrint("An error occurred while trying to get attachments for a task: " +
                    "\(error.localizedDescription)")
                completion?([])
            }
        }
    }
    
    
    func updateCommentForTask(with id: Int, comment: String, completion: Closure<Bool> = nil) {
        request(.updateTaskComment(taskId: id, comment: comment)) { (result) in
            switch result {
            case .success(_):
                completion?(true)
            case let .failure(error):
                debugPrint("An error occurred while trying to update a comment for a task: " +
                    "\(error.localizedDescription)")
                completion?(false)
            }
        }
    }
    
    
    func uploadAttachment(_ attachment: Data, forTaskWithId id: Int, completion: Closure<Int?> = nil) {
        request(.addAttachment(taskId: id, data: attachment)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data) as? NSDictionary
                    let id = json?["id"] as? Int
                    completion?(id)
                } catch {
                    print("Can not parse attachment upload response")
                }
            case let .failure(error):
                debugPrint("An error occurred while trying to upload attachment: " +
                    "\(error.localizedDescription)")
                completion?(nil)
            }
        }
    }
    
}


//MARK: - Students
extension APIProvider {
    
    func getStudents(_ completion: Closure<[StudentModel]>) {
        request(.students) { (result) in
            switch result {
            case let .success(moyaResponse):
                do {
                    let students = try moyaResponse.map([StudentModel].self)
                    completion?(students)
                } catch { print("Could not parse students in function \(#function)") }
            case let .failure(error):
                debugPrint("An error occurred while trying " +
                    "to get students: \(error.localizedDescription)")
                completion?([])
            }
        }
    }
}


//MARK: - Documents

extension APIProvider {
    
    func getBooks(_ completion: Closure<[DocumentFile]>) {
        request(.books) { (result) in
            switch result {
            case let .success(moyaResponse):
                do {
                    let books = try moyaResponse.map([DocumentFile].self)
                    completion?(books)
                } catch { print("Could not parse books in function \(#function)") }
            case let .failure(error):
                debugPrint("An error occurred while trying " +
                    "to get books: \(error.localizedDescription)")
                completion?([])
            }
        }
    }
    
    func downloadBook(_ document: DocumentFile, completion: Closure<Data?>) {
        request(.downloadFile(path: document.path)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                completion?(data)
            case let .failure(error):
                debugPrint("An error occurred while trying " +
                    "to get book: \(error.localizedDescription)")
                completion?(nil)
            }
        }
    }
    
}
