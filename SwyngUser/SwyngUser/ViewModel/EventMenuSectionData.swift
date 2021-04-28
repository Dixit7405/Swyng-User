//
//  EventMenuSectionData.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 28/04/21.
//

import Foundation

import RxDataSources

struct EventMenuSectionData {
  var items: [Item]
}
extension EventMenuSectionData: SectionModelType {
  typealias Item = String

   init(original: EventMenuSectionData, items: [Item]) {
    self = original
    self.items = items
  }
}
