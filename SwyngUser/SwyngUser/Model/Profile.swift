//
//  Profile.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 16, 2021

import Foundation

struct Profile : Codable {
    
    let bloodGroup : String?
    let dateOfBirth : String?
    let email : String?
    let emergencyContactName : String?
    let emergencyContactNumber : String?
    let fname : String?
    let gender : String?
    let lname : String?
    let mobileNo : String?
    let tShirtSize : String?
    
    enum CodingKeys: String, CodingKey {
        case bloodGroup = "bloodGroup"
        case dateOfBirth = "dateOfBirth"
        case email = "email"
        case emergencyContactName = "emergencyContactName"
        case emergencyContactNumber = "emergencyContactNumber"
        case fname = "fname"
        case gender = "gender"
        case lname = "lname"
        case mobileNo = "mobileNo"
        case tShirtSize = "tShirtSize"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bloodGroup = try values.decodeIfPresent(String.self, forKey: .bloodGroup)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        emergencyContactName = try values.decodeIfPresent(String.self, forKey: .emergencyContactName)
        emergencyContactNumber = try values.decodeIfPresent(String.self, forKey: .emergencyContactNumber)
        fname = try values.decodeIfPresent(String.self, forKey: .fname)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        lname = try values.decodeIfPresent(String.self, forKey: .lname)
        mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
        tShirtSize = try values.decodeIfPresent(String.self, forKey: .tShirtSize)
    }
    
}
