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
    let filesPath : FilesPath?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
        case suceess = "suceess"
        case filesPath = "filesPath"
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
        filesPath = try values.decodeIfPresent(FilesPath.self, forKey: .filesPath)
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

struct FilesPath : Codable {
    
    let fixerAndSchedulePath : String?
    let galleryPath : String?
    let publishedPath : String?
    let resultPath : String?
    
    enum CodingKeys: String, CodingKey {
        case fixerAndSchedulePath = "fixerAndSchedulePath"
        case galleryPath = "galleryPath"
        case publishedPath = "publishedPath"
        case resultPath = "resultPath"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fixerAndSchedulePath = try values.decodeIfPresent(String.self, forKey: .fixerAndSchedulePath)
        galleryPath = try values.decodeIfPresent(String.self, forKey: .galleryPath)
        publishedPath = try values.decodeIfPresent(String.self, forKey: .publishedPath)
        resultPath = try values.decodeIfPresent(String.self, forKey: .resultPath)
        ImageBase.fixerAndSchedulePath = fixerAndSchedulePath ?? ""
        ImageBase.galleryPath = galleryPath ?? ""
        ImageBase.publishedPath = publishedPath ?? ""
        ImageBase.resultPath = resultPath ?? ""
    }
    
}
