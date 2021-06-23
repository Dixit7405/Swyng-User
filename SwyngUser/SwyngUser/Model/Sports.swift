//
//  Sports.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 28, 2021

import Foundation

struct Sports : Codable {

        let createdAt : String?
        let id : Int?
        let isDeleted : Bool?
        let name : String?
        let status : Bool?
        let updatedAt : String?
        let user : Profile?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case createdAt = "createdAt"
                case id = "id"
                case isDeleted = "isDeleted"
                case name = "name"
                case status = "status"
                case updatedAt = "updatedAt"
                case user = "user"
                case userId = "userId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                user = try values.decodeIfPresent(Profile.self, forKey: .user)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}
