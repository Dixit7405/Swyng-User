//
//  RegisterCount.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 4, 2021

import Foundation

struct RegisterCount : Codable {

        let id : Int?
        let runId : Int?
        let tournamentId : Int?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case runId = "run_id"
                case tournamentId = "tournament_id"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                runId = try values.decodeIfPresent(Int.self, forKey: .runId)
                tournamentId = try values.decodeIfPresent(Int.self, forKey: .tournamentId)
        }

}
