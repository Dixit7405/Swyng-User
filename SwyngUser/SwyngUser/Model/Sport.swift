//
//  Sport.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 2, 2021

import Foundation

struct Sport : Codable {

        let about : String?
        let address : String?
        let allSports : [AllSport]?
        let amenities : String?
        let availableForSale : String?
        let availableOnRent : String?
        let booking : Bool?
        let bulkBookingDisPercentage : String?
        let bulkBookingStatus : Bool?
        let centerGuidelines : String?
        let centerTitle : String?
        let courts : [Court]?
        let email : String?
        let location : String?
        let mapDirection : String?
        let membershipPlan : Int?
        let membershipPlanDuration : Int?
        let membershipPlanName : MembershipPlanName?
        let membershipPlanPerCourt : Int?
        let membershipPlanPrice : Int?
        let memberShipPlan : [MemberShipPlan]?
        let onlineBookingStatus : Bool?
        let openHours : String?
        let people : [String]?
        let phoneNumber : String?
        let sportAvailable : [String]?
        let sportCenter : String?
        let sportCenterId : Int?
        let vendors : [Vendor]?
        let whatsapp : String?

        enum CodingKeys: String, CodingKey {
                case about = "about"
                case address = "address"
                case allSports = "allSports"
                case amenities = "amenities"
                case availableForSale = "available_for_sale"
                case availableOnRent = "available_on_rent"
                case booking = "booking"
                case bulkBookingDisPercentage = "bulk_booking_dis_percentage"
                case bulkBookingStatus = "bulk_booking_status"
                case centerGuidelines = "center_guidelines"
                case centerTitle = "center_title"
                case courts = "courts"
                case email = "email"
                case location = "location"
                case mapDirection = "map_direction"
                case membershipPlan = "membership_plan"
                case membershipPlanDuration = "membership_plan_duration"
                case membershipPlanName = "membership_plan_name"
                case membershipPlanPerCourt = "membership_plan_per_court"
                case membershipPlanPrice = "membership_plan_price"
                case memberShipPlan = "memberShipPlan"
                case onlineBookingStatus = "online_booking_status"
                case openHours = "open_hours"
                case people = "people"
                case phoneNumber = "phone_number"
                case sportAvailable = "sport_available"
                case sportCenter = "sport_center"
                case sportCenterId = "sport_center_id"
                case vendors = "vendors"
                case whatsapp = "whatsapp"
        }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        about = try values.decodeIfPresent(String.self, forKey: .about)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        allSports = try values.decodeIfPresent([AllSport].self, forKey: .allSports)
        amenities = try values.decodeIfPresent(String.self, forKey: .amenities)
        availableForSale = try values.decodeIfPresent(String.self, forKey: .availableForSale)
        availableOnRent = try values.decodeIfPresent(String.self, forKey: .availableOnRent)
        booking = try values.decodeIfPresent(Bool.self, forKey: .booking)
        bulkBookingDisPercentage = try values.decodeIfPresent(String.self, forKey: .bulkBookingDisPercentage)
        bulkBookingStatus = try values.decodeIfPresent(Bool.self, forKey: .bulkBookingStatus)
        centerGuidelines = try values.decodeIfPresent(String.self, forKey: .centerGuidelines)
        centerTitle = try values.decodeIfPresent(String.self, forKey: .centerTitle)
        courts = try values.decodeIfPresent([Court].self, forKey: .courts)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        mapDirection = try values.decodeIfPresent(String.self, forKey: .mapDirection)
        membershipPlan = try values.decodeIfPresent(Int.self, forKey: .membershipPlan)
        membershipPlanDuration = try values.decodeIfPresent(Int.self, forKey: .membershipPlanDuration)
        membershipPlanName = try values.decodeIfPresent(MembershipPlanName.self, forKey: .membershipPlanName)
        membershipPlanPerCourt = try values.decodeIfPresent(Int.self, forKey: .membershipPlanPerCourt)
        membershipPlanPrice = try values.decodeIfPresent(Int.self, forKey: .membershipPlanPrice)
        memberShipPlan = try values.decodeIfPresent([MemberShipPlan].self, forKey: .memberShipPlan)
        onlineBookingStatus = try values.decodeIfPresent(Bool.self, forKey: .onlineBookingStatus)
        openHours = try values.decodeIfPresent(String.self, forKey: .openHours)
        people = try values.decodeIfPresent([String].self, forKey: .people)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        sportAvailable = try values.decodeIfPresent([String].self, forKey: .sportAvailable)
        sportCenter = try values.decodeIfPresent(String.self, forKey: .sportCenter)
        sportCenterId = try values.decodeIfPresent(Int.self, forKey: .sportCenterId)
        vendors = try values.decodeIfPresent([Vendor].self, forKey: .vendors)
        whatsapp = try values.decodeIfPresent(String.self, forKey: .whatsapp)
    }

}

struct Vendor : Codable {

        let mobileNo : String?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case mobileNo = "mobileNo"
                case userId = "userId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}

struct MemberShipPlan : Codable {

        let createdAt : String?
        let isDeleted : Bool?
        let membershipPlanId : Int?
        let planName : String?
        let status : Bool?
        let updatedAt : String?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case createdAt = "createdAt"
                case isDeleted = "isDeleted"
                case membershipPlanId = "membership_plan_id"
                case planName = "plan_name"
                case status = "status"
                case updatedAt = "updatedAt"
                case userId = "userId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
                membershipPlanId = try values.decodeIfPresent(Int.self, forKey: .membershipPlanId)
                planName = try values.decodeIfPresent(String.self, forKey: .planName)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}

struct MembershipPlanName : Codable {

        let planName : String?

        enum CodingKeys: String, CodingKey {
                case planName = "plan_name"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                planName = try values.decodeIfPresent(String.self, forKey: .planName)
        }

}

struct AllSport : Codable {

        let createdAt : String?
        let id : Int?
        let isDeleted : Bool?
        let name : String?
        let status : Bool?
        let updatedAt : String?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case createdAt = "createdAt"
                case id = "id"
                case isDeleted = "isDeleted"
                case name = "name"
                case status = "status"
                case updatedAt = "updatedAt"
                case userId = "userId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}
