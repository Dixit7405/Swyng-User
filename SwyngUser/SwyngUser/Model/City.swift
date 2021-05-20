//
//  City.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 15, 2021

import Foundation

struct City : Codable {
    
    let cityId : Int?
    let createdAt : String?
    let isDeleted : Bool?
    let name : String?
    let status : Bool?
    let updatedAt : String?
    let user : User?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case cityId = "city_id"
        case createdAt = "createdAt"
        case isDeleted = "isDeleted"
        case name = "name"
        case status = "status"
        case updatedAt = "updatedAt"
        case user = "user"
        case userId = "userId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}

struct User : Codable {
    
    let email : String?
    let fname : String?
    let lname : String?
    let role : String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case fname = "fname"
        case lname = "lname"
        case role = "role"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        fname = try values.decodeIfPresent(String.self, forKey: .fname)
        lname = try values.decodeIfPresent(String.self, forKey: .lname)
        role = try values.decodeIfPresent(String.self, forKey: .role)
    }
    
}
