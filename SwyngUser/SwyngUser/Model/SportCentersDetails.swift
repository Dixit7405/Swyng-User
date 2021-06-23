//
//  SportCentersDetails.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 31, 2021

import Foundation

struct SportCentersDetails : Codable {

        let courtDetails : [CourtDetail]?
        let gallery : [Gallery]?
        let getVendorsDetails : [GetVendorsDetail]?
        let sport : Sport?
        let timingAndPricing : [TimingAndPricing]?

        enum CodingKeys: String, CodingKey {
                case courtDetails = "courtDetails"
                case gallery = "gallery"
                case getVendorsDetails = "getVendorsDetails"
                case sport = "sport"
                case timingAndPricing = "timingAndPricing"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                courtDetails = try values.decodeIfPresent([CourtDetail].self, forKey: .courtDetails)
                gallery = try values.decodeIfPresent([Gallery].self, forKey: .gallery)
                getVendorsDetails = try values.decodeIfPresent([GetVendorsDetail].self, forKey: .getVendorsDetails)
                sport = try values.decodeIfPresent(Sport.self, forKey: .sport)
                timingAndPricing = try values.decodeIfPresent([TimingAndPricing].self, forKey: .timingAndPricing)
        }

}

struct CourtDetail : Codable {
    
    let createdAt : String?
    let id : Int?
    let noOfCourt : Int?
    let sport : Sports?
    let sportCenterId : Int?
    let sportId : Int?
    let typesOfCourt : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case id = "id"
        case noOfCourt = "no_of_court"
        case sport = "sport"
        case sportCenterId = "sport_center_id"
        case sportId = "sport_id"
        case typesOfCourt = "types_of_court"
        case updatedAt = "updatedAt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        noOfCourt = try values.decodeIfPresent(Int.self, forKey: .noOfCourt)
        sport = try values.decodeIfPresent(Sports.self, forKey: .sport)
        sportCenterId = try values.decodeIfPresent(Int.self, forKey: .sportCenterId)
        sportId = try values.decodeIfPresent(Int.self, forKey: .sportId)
        typesOfCourt = try values.decodeIfPresent(String.self, forKey: .typesOfCourt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}

struct GetVendorsDetail : Codable {

        let email : String?
        let fname : String?
        let lname : String?
        let mobileNo : String?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case email = "email"
                case fname = "fname"
                case lname = "lname"
                case mobileNo = "mobileNo"
                case userId = "userId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                fname = try values.decodeIfPresent(String.self, forKey: .fname)
                lname = try values.decodeIfPresent(String.self, forKey: .lname)
                mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}

struct TimingAndPricing : Codable {

        let slotsDetails : [SlotsDetail]?
        let timing : Timing?

        enum CodingKeys: String, CodingKey {
                case slotsDetails = "slotsDetails"
                case timing = "timing"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                slotsDetails = try values.decodeIfPresent([SlotsDetail].self, forKey: .slotsDetails)
                timing = try values.decodeIfPresent(Timing.self, forKey: .timing)
        }

}

struct Timing : Codable {

       let court : Court?
       let courtId : Int?
       let courtName : String?
       let courtPricingDetail : String?
       let courtTimingPricingId : Int?
       let createdAt : String?
       let sportCenterId : Int?
       let updatedAt : String?

       enum CodingKeys: String, CodingKey {
               case court = "court"
               case courtId = "court_id"
               case courtName = "court_name"
               case courtPricingDetail = "court_pricing_detail"
               case courtTimingPricingId = "court_timing_pricing_id"
               case createdAt = "createdAt"
               case sportCenterId = "sport_center_id"
               case updatedAt = "updatedAt"
       }
   
       init(from decoder: Decoder) throws {
               let values = try decoder.container(keyedBy: CodingKeys.self)
               court = try values.decodeIfPresent(Court.self, forKey: .court)
               courtId = try values.decodeIfPresent(Int.self, forKey: .courtId)
               courtName = try values.decodeIfPresent(String.self, forKey: .courtName)
               courtPricingDetail = try values.decodeIfPresent(String.self, forKey: .courtPricingDetail)
               courtTimingPricingId = try values.decodeIfPresent(Int.self, forKey: .courtTimingPricingId)
               createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
               sportCenterId = try values.decodeIfPresent(Int.self, forKey: .sportCenterId)
               updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
       }

}

struct Court : Codable{

        let createdAt : String?
        let id : Int?
        let noOfCourt : Int?
        let sport : Sports?
        let sportCenterId : Int?
        let sportId : Int?
        let typesOfCourt : String?
        let updatedAt : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "createdAt"
                case id = "id"
                case noOfCourt = "no_of_court"
                case sport = "sport"
                case sportCenterId = "sport_center_id"
                case sportId = "sport_id"
                case typesOfCourt = "types_of_court"
                case updatedAt = "updatedAt"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                noOfCourt = try values.decodeIfPresent(Int.self, forKey: .noOfCourt)
                sport = try values.decodeIfPresent(Sports.self, forKey: .sport)
                sportCenterId = try values.decodeIfPresent(Int.self, forKey: .sportCenterId)
                sportId = try values.decodeIfPresent(Int.self, forKey: .sportId)
                typesOfCourt = try values.decodeIfPresent(String.self, forKey: .typesOfCourt)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        }

}

struct SlotsDetail : Codable {

        let fromDay : String?
        let price : String?
        let time : Time?
        let toDay : String?

        enum CodingKeys: String, CodingKey {
                case fromDay = "fromDay"
                case price = "price"
                case time = "time"
                case toDay = "toDay"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                fromDay = try values.decodeIfPresent(String.self, forKey: .fromDay)
                price = try values.decodeIfPresent(String.self, forKey: .price)
                time = try values.decodeIfPresent(Time.self, forKey: .time)
                toDay = try values.decodeIfPresent(String.self, forKey: .toDay)
        }

}

struct Time : Codable {

        let from : String?
        let slots : [Slot]?
        let to : String?

        enum CodingKeys: String, CodingKey {
                case from = "from"
                case slots = "slots"
                case to = "to"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                from = try values.decodeIfPresent(String.self, forKey: .from)
                slots = try values.decodeIfPresent([Slot].self, forKey: .slots)
                to = try values.decodeIfPresent(String.self, forKey: .to)
        }

}

struct Slot : Codable {

        let booked : Bool?
        let time : String?

        enum CodingKeys: String, CodingKey {
                case booked = "booked"
                case time = "time"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                booked = try values.decodeIfPresent(Bool.self, forKey: .booked)
                time = try values.decodeIfPresent(String.self, forKey: .time)
        }

}
