//
//  TournamentGallery.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 26, 2021

import Foundation

struct TournamentGallery : Codable {

        let createdAt : String?
        let id : Int?
        let image : String?
        let isDeleted : Bool?
        let tournamentId : Int?
        let updatedAt : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "createdAt"
                case id = "id"
                case image = "image"
                case isDeleted = "isDeleted"
                case tournamentId = "tournament_id"
                case updatedAt = "updatedAt"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                image = try values.decodeIfPresent(String.self, forKey: .image)
                isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
                tournamentId = try values.decodeIfPresent(Int.self, forKey: .tournamentId)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        }

}
