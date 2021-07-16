//
//  Favorite.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 4, 2021

import Foundation

struct Favourite : Codable {
    
    let favourite : Bool?
    let id : Int?
    let runId : Int?
    let tournamentId : Int?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case favourite = "favourite"
        case id = "id"
        case runId = "run_id"
        case tournamentId = "tournament_id"
        case userId = "userId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        favourite = try values.decodeIfPresent(Bool.self, forKey: .favourite)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        runId = try values.decodeIfPresent(Int.self, forKey: .runId)
        tournamentId = try values.decodeIfPresent(Int.self, forKey: .tournamentId)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}
