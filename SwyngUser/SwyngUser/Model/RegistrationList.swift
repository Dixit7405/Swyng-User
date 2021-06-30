//
//  RegistrationList.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 29, 2021

import Foundation

struct RegistrationList : Codable {
    
    let pastRegistration : [UpcomingRegistration]?
    let upcomingRegistration : [UpcomingRegistration]?
    
    enum CodingKeys: String, CodingKey {
        case pastRegistration = "pastRegistration"
        case upcomingRegistration = "upcomingRegistration"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pastRegistration = try values.decodeIfPresent([UpcomingRegistration].self, forKey: .pastRegistration)
        upcomingRegistration = try values.decodeIfPresent([UpcomingRegistration].self, forKey: .upcomingRegistration)
    }
    
}

struct UpcomingRegistration : Codable {
    
    let address : String?
    let cancelTicketCategory : [TicketCategory]?
    let dates : [String]?
    let ticketCategory : [TicketCategory]?
    let tournamentId : Int?
    let tournamentName : String?
    let runId:Int?
    let runName:String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case cancelTicketCategory = "cancel_ticket_category"
        case dates = "dates"
        case ticketCategory = "ticket_category"
        case tournamentId = "tournament_id"
        case tournamentName = "tournament_name"
        case runId = "run_id"
        case runName = "run_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        cancelTicketCategory = try values.decodeIfPresent([TicketCategory].self, forKey: .cancelTicketCategory)
        dates = try values.decodeIfPresent([String].self, forKey: .dates)
        ticketCategory = try values.decodeIfPresent([TicketCategory].self, forKey: .ticketCategory)
        tournamentId = try values.decodeIfPresent(Int.self, forKey: .tournamentId)
        tournamentName = try values.decodeIfPresent(String.self, forKey: .tournamentName)
        runId = try values.decodeIfPresent(Int.self, forKey: .runId)
        runName = try values.decodeIfPresent(String.self, forKey: .runName)
    }
    
}

struct TicketCategory : Codable {
    
    let id : Int?
    let tournamentCategory : TournamentCategory?
    let runCategory:RunsCategory?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case tournamentCategory = "tournament_category"
        case runCategory = "run_category"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        tournamentCategory = try values.decodeIfPresent(TournamentCategory.self, forKey: .tournamentCategory)
        runCategory = try values.decodeIfPresent(RunsCategory.self, forKey: .runCategory)
    }
    
}
