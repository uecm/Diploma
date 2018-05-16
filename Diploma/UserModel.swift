//
//  UserModel.swift
//  Diploma
//
//  Created by Egor on 5/3/18.
//  Copyright © 2018 egor. All rights reserved.
//

import Foundation

struct UserModel: Codable, Hashable {
    
    enum UserCodingKey: CodingKey {
        case id
        case name
        case email
        case password
    }
    
    let id: Int
    let name: String
    let email: String
    let password: String?
    
    var hashValue: Int {
        return name.hashValue ^ email.hashValue
    }
    
    init(id: Int, name: String, email: String, password: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKey.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let email = try container.decode(String.self, forKey: .email)
        let password = try container.decodeIfPresent(String.self, forKey: .password)
        
        self.init(id: id, name: name, email: email, password: password)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKey.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encodeIfPresent(password, forKey: .password)
    }
}
