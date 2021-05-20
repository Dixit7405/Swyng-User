//
//  Datum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 15, 2021

import Foundation

struct Register : Codable {
    
    let token : String?
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
    
}
