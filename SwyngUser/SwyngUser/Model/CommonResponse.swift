//
//  CommonResponse.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 15, 2021

import Foundation

struct CommonResponse<T:Codable> : Codable {
    
    let data : T?
    let message : String?
    let success : Bool?
    let suceess : Bool?
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
        case suceess = "suceess"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(T.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        if let suc = try! values.decodeIfPresent(Bool.self, forKey: .success){
            success = suc
        }
        else{
            success = try values.decodeIfPresent(Bool.self, forKey: .suceess)
        }
        suceess = try values.decodeIfPresent(Bool.self, forKey: .suceess)
    }
    
}

struct PagingData<T:Codable>:Codable {
    let currentPage:Int?
    let totalItems:Int?
    let totalPages:Int?
    let data:[T]?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "currentPage"
        case totalItems = "totalItems"
        case totalPages = "totalPages"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        totalItems = try values.decodeIfPresent(Int.self, forKey: .totalItems)
        data = try values.decodeIfPresent([T].self, forKey: .data)
    }
}
