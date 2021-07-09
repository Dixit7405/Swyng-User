//
//  TournamentRegistrationData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 29, 2021

import Foundation

struct TournamentRegistrationData : Codable {
    
    let bookingId : String?
    let cancelTickets : [CancelTicket]?
    let tickets : [CancelTicket]?
    let tournament : Tournament?
    let cancelationRules:[CancelationRule]?
    let run:Tournament?
    let user : User?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case cancelTickets = "cancel_tickets"
        case tickets = "tickets"
        case tournament = "tournament"
        case run = "run"
        case user = "user"
        case cancelationRules = "cancelationRules"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingId = try values.decodeIfPresent(String.self, forKey: .bookingId)
        cancelTickets = try values.decodeIfPresent([CancelTicket].self, forKey: .cancelTickets)
        tickets = try values.decodeIfPresent([CancelTicket].self, forKey: .tickets)
        tournament = try values.decodeIfPresent(Tournament.self, forKey: .tournament)
        run = try values.decodeIfPresent(Tournament.self, forKey: .run)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        cancelationRules = try values.decodeIfPresent([CancelationRule].self, forKey: .cancelationRules)
    }
    
}

struct Tournament : Codable {
    
    let aboutOrganizer : String?
    let city : String?
    let dates : [String]?
    let pleaseNote : String?
    let termsAndCondition : String?
    let tournamentId : Int?
    let runId:Int?
    let venue : String?
    let venueAddress : String?
    let venueGoogleMap : String?
    let address:String?
    let routeMap:String?
    
    enum CodingKeys: String, CodingKey {
        case aboutOrganizer = "aboutOrganizer"
        case city = "city"
        case dates = "dates"
        case pleaseNote = "pleaseNote"
        case termsAndCondition = "termsAndCondition"
        case tournamentId = "tournament_id"
        case runId = "run_id"
        case venue = "venue"
        case venueAddress = "venue_address"
        case venueGoogleMap = "venue_google_map"
        case routeMap = "routeMap"
        case address = "address"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        aboutOrganizer = try values.decodeIfPresent(String.self, forKey: .aboutOrganizer)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        dates = try values.decodeIfPresent([String].self, forKey: .dates)
        pleaseNote = try values.decodeIfPresent(String.self, forKey: .pleaseNote)
        termsAndCondition = try values.decodeIfPresent(String.self, forKey: .termsAndCondition)
        tournamentId = try values.decodeIfPresent(Int.self, forKey: .tournamentId)
        runId = try values.decodeIfPresent(Int.self, forKey: .runId)
        venue = try values.decodeIfPresent(String.self, forKey: .venue)
        venueAddress = try values.decodeIfPresent(String.self, forKey: .venueAddress)
        venueGoogleMap = try values.decodeIfPresent(String.self, forKey: .venueGoogleMap)
        routeMap = try values.decodeIfPresent(String.self, forKey: .routeMap)
        address = try values.decodeIfPresent(String.self, forKey: .address)
    }
    
}

struct CancelTicket : Codable {

        let category : Category?
        let eventName : String?
        let ticketId : Int?
        let txnToken : String?

        enum CodingKeys: String, CodingKey {
                case category = "category"
                case eventName = "eventName"
                case ticketId = "ticket_id"
                case txnToken = "txnToken"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                category = try values.decodeIfPresent(Category.self, forKey: .category)
                eventName = try values.decodeIfPresent(String.self, forKey: .eventName)
                ticketId = try values.decodeIfPresent(Int.self, forKey: .ticketId)
                txnToken = try values.decodeIfPresent(String.self, forKey: .txnToken)
        }

}

struct Category : Codable {

        let amount : String?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case amount = "amount"
                case name = "name"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                amount = try values.decodeIfPresent(String.self, forKey: .amount)
                name = try values.decodeIfPresent(String.self, forKey: .name)
        }

}
