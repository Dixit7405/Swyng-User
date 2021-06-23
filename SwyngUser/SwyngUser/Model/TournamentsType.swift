//
//  TournamentsType.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 30, 2021

import Foundation

struct TournamentsType : Codable {
    
    let createdAt : String?
    let isDeleted : Bool?
    let name : String?
    let status : Bool?
    let isSingle:Bool?
    let tournamentCategoryId : Int?
    let updatedAt : String?
    let user : Profile?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case isDeleted = "isDeleted"
        case name = "name"
        case status = "status"
        case tournamentCategoryId = "tournament_category_id"
        case updatedAt = "updatedAt"
        case user = "user"
        case userId = "userId"
        case isSingle = "isSingle"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        do{
            isSingle = try values.decodeIfPresent(Bool.self, forKey: .isSingle)
        }
        catch{
            let single = try values.decodeIfPresent(String.self, forKey: .isSingle)
            isSingle = Bool(single ?? "0")
        }
        tournamentCategoryId = try values.decodeIfPresent(Int.self, forKey: .tournamentCategoryId)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        user = try values.decodeIfPresent(Profile.self, forKey: .user)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}
