//
//  ManageCenterVM.swift
//  Swyng
//
//  Created by Dixit Rathod on 04/06/21.
//

import Foundation
import RxCocoa

struct ManageCenterVM {
    var centerData = BehaviorRelay<[SportCenters]>(value:[])
    var sportData = BehaviorRelay<[Sports]>(value:[])
    var selectedCenters = BehaviorRelay<[Int]>(value: [])
    var selectedSpors = BehaviorRelay<[Int]>(value: [])
    var tableHeight = BehaviorRelay<CGFloat>(value:0)
    var collectionHeight = BehaviorRelay<CGFloat>(value:0)
    var alertMessage = BehaviorRelay<String>(value: "")
    
    
    func getAllSportCenters(failureBlock:@escaping FailureBlock, successResponse: @escaping(CommonResponse<[SportCenters]>)->Void){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getSportCenters, type: CommonResponse<[SportCenters]>.self, failer: failureBlock) { success in
            guard let response = success as? CommonResponse<[SportCenters]> else {return}
            if let data = response.data{
                self.centerData.accept(data)
                
            }
            else{
                alertMessage.accept(response.message ?? "")
            }
            successResponse(response)
        }
    }
    
    func getSportsList(failure: @escaping FailureBlock, successResponse:@escaping (CommonResponse<[Sports]>) -> Void){
        Webservices().request(with: [:], method: .get, endPoint: EndPoints.getAllSports, type: CommonResponse<[Sports]>.self, failer: failure) { success in
            guard let response = success as? CommonResponse<[Sports]> else {return}
            if let data = response.data{
                self.sportData.accept(data)
            }
            else{
                alertMessage.accept(response.message ?? "")
            }
            successResponse(response)
        }
    }
}
