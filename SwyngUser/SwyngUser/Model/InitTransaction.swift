//
//  InitTransaction.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 25, 2021

import Foundation

struct InitTransaction : Codable {
    
    let body : Body?
    let head : Head?
    
    enum CodingKeys: String, CodingKey {
        case body = "body"
        case head = "head"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        body = try values.decodeIfPresent(Body.self, forKey: .body)
        head = try values.decodeIfPresent(Head.self, forKey: .head)
    }
    
}

struct Head : Codable {

        let responseTimestamp : String?
        let signature : String?
        let version : String?

        enum CodingKeys: String, CodingKey {
                case responseTimestamp = "responseTimestamp"
                case signature = "signature"
                case version = "version"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                responseTimestamp = try values.decodeIfPresent(String.self, forKey: .responseTimestamp)
                signature = try values.decodeIfPresent(String.self, forKey: .signature)
                version = try values.decodeIfPresent(String.self, forKey: .version)
        }

}

struct Body : Codable {

        let authenticated : Bool?
        let isPromoCodeValid : Bool?
        let resultInfo : ResultInfo?
        let txnToken : String?

        enum CodingKeys: String, CodingKey {
                case authenticated = "authenticated"
                case isPromoCodeValid = "isPromoCodeValid"
                case resultInfo = "resultInfo"
                case txnToken = "txnToken"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                authenticated = try values.decodeIfPresent(Bool.self, forKey: .authenticated)
                isPromoCodeValid = try values.decodeIfPresent(Bool.self, forKey: .isPromoCodeValid)
                resultInfo = try values.decodeIfPresent(ResultInfo.self, forKey: .resultInfo)
                txnToken = try values.decodeIfPresent(String.self, forKey: .txnToken)
        }

}

struct ResultInfo : Codable {

        let resultCode : String?
        let resultMsg : String?
        let resultStatus : String?

        enum CodingKeys: String, CodingKey {
                case resultCode = "resultCode"
                case resultMsg = "resultMsg"
                case resultStatus = "resultStatus"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                resultCode = try values.decodeIfPresent(String.self, forKey: .resultCode)
                resultMsg = try values.decodeIfPresent(String.self, forKey: .resultMsg)
                resultStatus = try values.decodeIfPresent(String.self, forKey: .resultStatus)
        }

}
