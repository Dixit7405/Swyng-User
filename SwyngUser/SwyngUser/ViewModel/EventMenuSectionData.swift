//
//  EventMenuSectionData.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 28/04/21.
//

import Foundation
import RxDataSources

enum EventMenuOptions:String {
    case home = "Home"
    case accountInfo = "Account Info"
    case sportsCenter = "Sports Centers"
    case bookings = "Bookings"
    case bulkbookings = "Bulk Bookings"
    case sportsTournaments = "Sports Tournaments"
    case tournamenRegistrations = "Tournament\nRegistrations"
    case runs = "Runs"
    case runRegistrations = "Run\nRegistrations"
    case cancelRules = "Cancelation & Rescheduling Rules"
    case paymentPolicy = "Payments Policy"
    case aboutSwyngs = "About SWYNG"
    case partner = "Partner with SWYNG"
    case terms = "Terms of use"
    case privacy = "Privacy Policy"
}

struct EventMenuSectionData {
  var items: [Item]
}
extension EventMenuSectionData: SectionModelType {
  typealias Item = EventMenuOptions

   init(original: EventMenuSectionData, items: [Item]) {
    self = original
    self.items = items
  }
}
