//
//  TournamentRegister.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 25, 2021

import Foundation

struct TournamentRegister : Codable {

        let amount : String?
        let bookingId : String?
        let createdAt : String?
        let id : Int?
        let orderId : String?
        let signature : String?
        let ticketId : [Int]?
        let tournamentId : Int?
        let txnToken : String?
        let updatedAt : String?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case amount = "amount"
                case bookingId = "booking_id"
                case createdAt = "createdAt"
                case id = "id"
                case orderId = "order_id"
                case signature = "signature"
                case ticketId = "ticket_id"
                case tournamentId = "tournament_id"
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
                signature = try values.decodeIfPresent(String.self, forKey: .signature)
                ticketId = try values.decodeIfPresent([Int].self, forKey: .ticketId)
                tournamentId = try values.decodeIfPresent(Int.self, forKey: .tournamentId)
                txnToken = try values.decodeIfPresent(String.self, forKey: .txnToken)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}
