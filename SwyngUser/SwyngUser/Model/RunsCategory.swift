//
//  RunsCategory.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 19, 2021

import Foundation

struct RunsCategory : Codable {
    
    let createdAt : String?
    let isDeleted : Bool?
    let name : String?
    let runCategoriesId : Int?
    let status : Bool?
    let isSingle:Bool?
    let updatedAt : String?
    let user : User?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case isDeleted = "isDeleted"
        case name = "name"
        case runCategoriesId = "run_categories_id"
        case status = "status"
        case isSingle = "isSingle"
        case updatedAt = "updatedAt"
        case user = "user"
        case userId = "userId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        runCategoriesId = try values.decodeIfPresent(Int.self, forKey: .runCategoriesId)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        do{
            isSingle = try values.decodeIfPresent(Bool.self, forKey: .isSingle)
        }
        catch{
            let single = try values.decodeIfPresent(String.self, forKey: .isSingle)
            isSingle = Bool(single ?? "false")
        }
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}
