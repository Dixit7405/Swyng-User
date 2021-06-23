//
//  SportCenters.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 31, 2021

import Foundation

struct SportCenters : Codable {

        let centerTitle : String?
        let sportCenter : String?
        let sportCenterId : Int?

        enum CodingKeys: String, CodingKey {
                case centerTitle = "center_title"
                case sportCenter = "sport_center"
                case sportCenterId = "sport_center_id"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                centerTitle = try values.decodeIfPresent(String.self, forKey: .centerTitle)
                sportCenter = try values.decodeIfPresent(String.self, forKey: .sportCenter)
                sportCenterId = try values.decodeIfPresent(Int.self, forKey: .sportCenterId)
        }

}
