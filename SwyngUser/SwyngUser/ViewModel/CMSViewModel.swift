//
//  CMSViewModel.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 28/04/21.
//

import Foundation
import RxSwift
import RxCocoa

enum PageType:String {
    case terms = "Terms Of Use"
    case privacy = "Privacy Policy"
    case cancellationRules = "Cancelations &\nRescheduling Rules"
    case paymentPolicy = "Payments Policy"
    case aboutSwyng = "About SWYNG"
}

enum PageImage:String {
    case terms = "header_terms"
    case privacy = "header_privacy"
    case cancellationRules = "header_cancellation"
    case paymentPolicy = "header_payment"
    case aboutSwyng = "header_about"
}

struct CMSViewModel {
    var type = BehaviorRelay<PageType>(value: .terms)
    var image = BehaviorRelay<PageImage>(value: .terms)
}
