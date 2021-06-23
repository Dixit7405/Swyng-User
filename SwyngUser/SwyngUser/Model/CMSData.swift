//
//  CMSData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 30, 2021

import Foundation

struct CMSData : Codable {

        let cancelationReschedulingRulesId : Int?
        let createdAt : String?
        let isDeleted : Bool?
        let text : String?
        let updatedAt : String?
        let user : Profile?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case cancelationReschedulingRulesId = "cancelation_rescheduling_rules_id"
                case createdAt = "createdAt"
                case isDeleted = "isDeleted"
                case text = "text"
                case updatedAt = "updatedAt"
                case user = "user"
                case userId = "userId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                cancelationReschedulingRulesId = try values.decodeIfPresent(Int.self, forKey: .cancelationReschedulingRulesId)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
                text = try values.decodeIfPresent(String.self, forKey: .text)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                user = try values.decodeIfPresent(Profile.self, forKey: .user)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}
