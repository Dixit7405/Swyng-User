//
//  CancelationRule.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 4, 2021

import Foundation

struct CancelationRule : Codable {
    
    let age : String?
    let cancelationTournamentId : Int?
    let cancelationRunId : Int?
    let time : String?
    
    enum CodingKeys: String, CodingKey {
        case age = "age"
        case cancelationTournamentId = "cancelation_tournament_id"
        case cancelationRunId = "cancelation_run_id"
        case time = "time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        cancelationTournamentId = try values.decodeIfPresent(Int.self, forKey: .cancelationTournamentId)
        cancelationRunId = try values.decodeIfPresent(Int.self, forKey: .cancelationRunId)
        time = try values.decodeIfPresent(String.self, forKey: .time)
    }
    
}
