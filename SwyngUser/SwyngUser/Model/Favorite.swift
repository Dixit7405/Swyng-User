//
//  Favorite.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 24, 2021

import Foundation

struct Favorite : Codable {

        let createdAt : String?
        let favourite : Bool?
        let id : Int?
        let tournamentId : Int?
        let updatedAt : String?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case createdAt = "createdAt"
                case favourite = "favourite"
                case id = "id"
                case tournamentId = "tournament_id"
                case updatedAt = "updatedAt"
                case userId = "userId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                favourite = try values.decodeIfPresent(Bool.self, forKey: .favourite)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                tournamentId = try values.decodeIfPresent(Int.self, forKey: .tournamentId)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}
