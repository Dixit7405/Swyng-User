//
//  Gallery.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 31, 2021

import Foundation

struct Gallery : Codable {
    
    let id : Int?
    let image : String?
    let sportCenterId : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case sportCenterId = "sport_center_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        sportCenterId = try values.decodeIfPresent(Int.self, forKey: .sportCenterId)
    }
    
}
