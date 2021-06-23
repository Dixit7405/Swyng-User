//
//  Participants.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 1, 2021

import Foundation

struct Participants : Codable {
    
    let createdAt : String?
    let email : String?
    let email1 : String?
    let fname : String?
    let fname1 : String?
    let id : Int?
    let isDeleted : Bool?
    let lname : String?
    let lname1 : String?
    let mobileNo : String?
    let mobileNo1 : String?
    let tournamentCategory : TournamentCategory?
    let tournamentCategoryId : Int?
    let tournamentId : Int?
    let updatedAt : String?
    let updatedBy : Int?
    let updatedByTblUser : UpdatedByTblUser?
    let runId : Int?
    let runCategoryId : Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case email = "email"
        case email1 = "email1"
        case fname = "fname"
        case fname1 = "fname1"
        case id = "id"
        case isDeleted = "isDeleted"
        case lname = "lname"
        case lname1 = "lname1"
        case mobileNo = "mobileNo"
        case mobileNo1 = "mobileNo1"
        case tournamentCategory = "tournament_category"
        case tournamentCategoryId = "tournament_category_id"
        case tournamentId = "tournament_id"
        case updatedAt = "updatedAt"
        case updatedBy = "updatedBy"
        case updatedByTblUser = "updatedBy_tbl_user"
        case runId = "run_id"
        case runCategoryId = "run_category_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        email1 = try values.decodeIfPresent(String.self, forKey: .email1)
        fname = try values.decodeIfPresent(String.self, forKey: .fname)
        fname1 = try values.decodeIfPresent(String.self, forKey: .fname1)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
        lname = try values.decodeIfPresent(String.self, forKey: .lname)
        lname1 = try values.decodeIfPresent(String.self, forKey: .lname1)
        mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
        mobileNo1 = try values.decodeIfPresent(String.self, forKey: .mobileNo1)
        tournamentCategory = try values.decodeIfPresent(TournamentCategory.self, forKey: .tournamentCategory)
        tournamentCategoryId = try values.decodeIfPresent(Int.self, forKey: .tournamentCategoryId)
        tournamentId = try values.decodeIfPresent(Int.self, forKey: .tournamentId)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        updatedBy = try values.decodeIfPresent(Int.self, forKey: .updatedBy)
        runId = try values.decodeIfPresent(Int.self, forKey: .runId)
        runCategoryId = try values.decodeIfPresent(Int.self, forKey: .runCategoryId)
        updatedByTblUser = try values.decodeIfPresent(UpdatedByTblUser.self, forKey: .updatedByTblUser)
    }
    
}

struct UpdatedByTblUser : Codable {
    
    let email : String?
    let fname : String?
    let lname : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case fname = "fname"
        case lname = "lname"
        case userId = "userId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        fname = try values.decodeIfPresent(String.self, forKey: .fname)
        lname = try values.decodeIfPresent(String.self, forKey: .lname)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}

struct TournamentCategory : Codable {
    
    let name : String?
    let tournamentCategoryId : Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case tournamentCategoryId = "tournament_category_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        tournamentCategoryId = try values.decodeIfPresent(Int.self, forKey: .tournamentCategoryId)
    }
    
}
