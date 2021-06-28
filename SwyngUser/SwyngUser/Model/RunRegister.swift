//
//  RunRegister.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 25, 2021

import Foundation

struct RunRegister : Codable {

        let amount : String?
        let bookingId : String?
        let createdAt : String?
        let id : Int?
        let orderId : String?
        let runId : Int?
        let signature : String?
        let ticketId : [Int]?
        let txnToken : String?
        let updatedAt : String?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case amount = "amount"
                case bookingId = "booking_id"
                case createdAt = "createdAt"
                case id = "id"
                case orderId = "order_id"
                case runId = "run_id"
                case signature = "signature"
                case ticketId = "ticket_id"
                case txnToken = "txnToken"
                case updatedAt = "updatedAt"
                case userId = "userId"
        }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do{
            amount = try values.decodeIfPresent(String.self, forKey: .amount)
        }
        catch{
            let amt = try values.decodeIfPresent(Int.self, forKey: .amount) ?? 0
            amount = String(format: "%d", amt)
        }
        bookingId = try values.decodeIfPresent(String.self, forKey: .bookingId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        runId = try values.decodeIfPresent(Int.self, forKey: .runId)
        signature = try values.decodeIfPresent(String.self, forKey: .signature)
        ticketId = try values.decodeIfPresent([Int].self, forKey: .ticketId)
        txnToken = try values.decodeIfPresent(String.self, forKey: .txnToken)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }

}
