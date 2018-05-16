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
