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
    var content = BehaviorRelay<String>(value: "No data available")
    var alert = BehaviorRelay<String>(value: "")
    
    func getCMSPageData(completion:@escaping(() -> Void)){
        var endPoints = ""
        switch type.value {
        case .terms:
            endPoints = EndPoints.termsOfUse
        case .privacy:
            endPoints = EndPoints.privacyPolicy
        case .cancellationRules:
            endPoints = EndPoints.cancellationRules
        case .paymentPolicy:
            endPoints = EndPoints.paymentPolicy
        case .aboutSwyng:
            endPoints = EndPoints.aboutSwyng
        }
        Webservices().request(with: [:], method: .get, endPoint: endPoints, type: CommonResponse<[CMSData]>.self) { failure,status  in
            alert.accept(failure)
            completion()
        } success: { success in
            guard let response = success as? CommonResponse<[CMSData]> else {return}
            if response.success == true{
                content.accept(response.data?.first?.text ?? "")
            }
            else{
                alert.accept(response.message ?? "")
            }
            completion()
        }

    }
}
