//
//  Tournaments.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 16, 2021

import Foundation

struct Tournaments : Codable {

        let aboutOrganizer : String?
        let aboutTournament : String?
        let allowedEntries : Int?
        let asPerSchedule : Bool?
        let categoryId : [String]?
        let createdAt : String?
        let creativeFontColor : String?
        let dates : [String]?
        let eventStartTime : String?
        let eventName : String?
        let fixerAndSchedulePdf : String?
        let frequentlyAskedQuestion : String?
        let galleryImage : String?
        let gender : String?
        let headerImage : String?
        let isOnlineRegistration : Bool?
        let isDeleted : Bool?
        let noOfPlayers : Int?
        let organizer : String?
        let participationFee : String?
        let peopleMobileNumber : String?
        let pleaseNote : String?
        let registerBeforeFromStartTime : String?
        let reportingTime : String?
        let rewards : String?
        let sportId : [String]?
        let termsAndCondition : String?
        let thumbnailImage : String?
        let tournamentId : Int?
        let tournamentName : String?
        let tournamentTicketCategory : Int?
        let tournamentInformation : String?
        let tournamentResult : String?
        let updatedAt : String?
        let userId : Int?
        let venue : String?
        let venueAddress : String?
        let venueCity : Int?
        let venueGoogleMap : String?

        enum CodingKeys: String, CodingKey {
                case aboutOrganizer = "aboutOrganizer"
                case aboutTournament = "aboutTournament"
                case allowedEntries = "allowed_entries"
                case asPerSchedule = "as_per_schedule"
                case categoryId = "category_id"
                case createdAt = "createdAt"
                case creativeFontColor = "creativeFontColor"
                case dates = "dates"
                case eventStartTime = "event_start_time"
                case eventName = "eventName"
                case fixerAndSchedulePdf = "fixerAndSchedulePdf"
                case frequentlyAskedQuestion = "frequentlyAskedQuestion"
                case galleryImage = "galleryImage"
                case gender = "gender"
                case headerImage = "headerImage"
                case isOnlineRegistration = "is_online_registration"
                case isDeleted = "isDeleted"
                case noOfPlayers = "noOfPlayers"
                case organizer = "organizer"
                case participationFee = "participationFee"
                case peopleMobileNumber = "peopleMobileNumber"
                case pleaseNote = "pleaseNote"
                case registerBeforeFromStartTime = "register_before_from_start_time"
                case reportingTime = "reporting_time"
                case rewards = "rewards"
                case sportId = "sport_id"
                case termsAndCondition = "termsAndCondition"
                case thumbnailImage = "thumbnailImage"
                case tournamentId = "tournament_id"
                case tournamentName = "tournament_name"
                case tournamentTicketCategory = "tournament_ticket_category"
                case tournamentInformation = "tournamentInformation"
                case tournamentResult = "tournamentResult"
                case updatedAt = "updatedAt"
                case userId = "user_id"
                case venue = "venue"
                case venueAddress = "venue_address"
                case venueCity = "venue_city"
                case venueGoogleMap = "venue_google_map"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                aboutOrganizer = try values.decodeIfPresent(String.self, forKey: .aboutOrganizer)
                aboutTournament = try values.decodeIfPresent(String.self, forKey: .aboutTournament)
                allowedEntries = try values.decodeIfPresent(Int.self, forKey: .allowedEntries)
                asPerSchedule = try values.decodeIfPresent(Bool.self, forKey: .asPerSchedule)
                categoryId = try values.decodeIfPresent([String].self, forKey: .categoryId)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                creativeFontColor = try values.decodeIfPresent(String.self, forKey: .creativeFontColor)
                dates = try values.decodeIfPresent([String].self, forKey: .dates)
                eventStartTime = try values.decodeIfPresent(String.self, forKey: .eventStartTime)
                eventName = try values.decodeIfPresent(String.self, forKey: .eventName)
                fixerAndSchedulePdf = try values.decodeIfPresent(String.self, forKey: .fixerAndSchedulePdf)
                frequentlyAskedQuestion = try values.decodeIfPresent(String.self, forKey: .frequentlyAskedQuestion)
                galleryImage = try values.decodeIfPresent(String.self, forKey: .galleryImage)
                gender = try values.decodeIfPresent(String.self, forKey: .gender)
                headerImage = try values.decodeIfPresent(String.self, forKey: .headerImage)
                isOnlineRegistration = try values.decodeIfPresent(Bool.self, forKey: .isOnlineRegistration)
                isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
                noOfPlayers = try values.decodeIfPresent(Int.self, forKey: .noOfPlayers)
                organizer = try values.decodeIfPresent(String.self, forKey: .organizer)
                participationFee = try values.decodeIfPresent(String.self, forKey: .participationFee)
                peopleMobileNumber = try values.decodeIfPresent(String.self, forKey: .peopleMobileNumber)
                pleaseNote = try values.decodeIfPresent(String.self, forKey: .pleaseNote)
                registerBeforeFromStartTime = try values.decodeIfPresent(String.self, forKey: .registerBeforeFromStartTime)
                reportingTime = try values.decodeIfPresent(String.self, forKey: .reportingTime)
                rewards = try values.decodeIfPresent(String.self, forKey: .rewards)
                sportId = try values.decodeIfPresent([String].self, forKey: .sportId)
                termsAndCondition = try values.decodeIfPresent(String.self, forKey: .termsAndCondition)
                thumbnailImage = try values.decodeIfPresent(String.self, forKey: .thumbnailImage)
                tournamentId = try values.decodeIfPresent(Int.self, forKey: .tournamentId)
                tournamentName = try values.decodeIfPresent(String.self, forKey: .tournamentName)
                tournamentTicketCategory = try values.decodeIfPresent(Int.self, forKey: .tournamentTicketCategory)
                tournamentInformation = try values.decodeIfPresent(String.self, forKey: .tournamentInformation)
                tournamentResult = try values.decodeIfPresent(String.self, forKey: .tournamentResult)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
                venue = try values.decodeIfPresent(String.self, forKey: .venue)
                venueAddress = try values.decodeIfPresent(String.self, forKey: .venueAddress)
                venueCity = try values.decodeIfPresent(Int.self, forKey: .venueCity)
                venueGoogleMap = try values.decodeIfPresent(String.self, forKey: .venueGoogleMap)
        }

}
