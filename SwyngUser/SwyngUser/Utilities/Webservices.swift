//
//  Webservices.swift
//  Banaji
//
//  Created by Dixit Rathod on 30/03/20.
//  Copyright © 2020 Sassy Infotech. All rights reserved.
//

import Foundation
import Alamofire
import KDCircularProgress

var authorization = ""
let baseURL = "http://ec2-54-234-213-111.compute-1.amazonaws.com/"
let imageBase = "http://ec2-54-234-213-111.compute-1.amazonaws.com"

typealias FailureBlock = ((String, Int?) -> Void)

struct Parameters {
    static let fname = "fname"
    static let lname = "lname"
    static let email = "email"
    static let mobileNo = "mobileNo"
    static let otp = "OTP"
    static let token = "token"
    static let dateOfBirth = "dateOfBirth"
    static let gender = "gender"
    static let bloodGroup = "bloodGroup"
    static let tShirtSize = "tShirtSize"
    static let emergencyContactName = "emergencyContactName"
    static let emergencyContactNumber = "emergencyContactNumber"
    static let cityId = "cityId"
    static let fname1 = "fname1"
    static let lname1 = "lname1"
    static let email1 = "email1"
    static let mobileNo1 = "mobileNo1"
    static let tournamentResult = "tournamentResult"
    static let runResult = "runResult"
    static let runPublished = "runPublished"
    static let fixerAndSchedulePdf = "fixerAndSchedulePdf"
    static let image = "image"
    static let id = "id"
    static let key = "key"
    static let tournamentCategoryId = "tournament_category_id"
    static let runsCategoryId = "run_category_id"
    static let offset = "offset"
    static let size = "size"
    static let sport = "sport"
    static let location = "location"
    static let tournament_id = "tournament_id"
    static let favourite = "favourite"
    static let amount = "amount"
    static let run_id = "run_id"
    static let orderId = "orderId"
    static let signature = "signature"
    static let txnToken = "txnToken"
    static let booking_id = "booking_id"
    static let ticket_id = "ticket_id"
    static let cancel_category_id = "cancel_category_id"
    static let refund_amount = "refund_amount"
    static let remain_ticket_id = "remain_ticket_id"
}

struct EndPoints {
    static let registerUser = "mobile/user/signUp"
    static let getCities = "city/getAll"
    static let sendOTP = "account/user/otp/send"
    static let resendOTP = "account/user/otp/resend"
    static let verifyOTP = "account/user/otp/verify"
    static let getProfile = "mobile/user/getProfile"
    static let getAllSports = "sport/getAllSports"
    static let createParticipant = "tournament/create/tournamentParticipants"
    static let uploadTournamentResult = "tournament/update/tournamentResult"
    static let uploadRunResult = "run/update/run-result"
    static let uploadTournamentFixture = "tournament/update/tournamentFixerSchedule"
    static let uploadTournamentGallery = "tournament/update/gallery"
    static let uploadRunsPublished = "run/update/run-published"
    static let getTournamentTypes = "tournamentCategory/getAll"
    static let getRunsCategory = "runCategory/getAll"
    static let paymentPolicy = "rules/paymentPolicy/getAll"
    static let aboutSwyng = "rules/aboutSwyng/getAll"
    static let partnerWithSwyng = "rules/partnerWithUs/getAll"
    static let cancellationRules = "rules/cancelation/getAll"
    static let privacyPolicy = "rules/privacyAndPolicy/getAll"
    static let termsOfUse = "rules/termsOfUse/getAll"
    static let getSportCenters = "mobile/vendor/getSportCenter"
    static let getSportCenterDetails = "mobile/sport-center/getById"
    static let searchSportCenter = "mobile/sport-center/search"
    static let getParticipantList = "mobile/tournament/get/tournamentParticipants"
    static let getRunsParticipants = "mobile/run/get/participants"
    static let addPartipant = "mobile/tournament/create/tournamentParticipants"
    static let addRunsPartipant = "mobile/run/create/participants"
    static let getSportCenterByFilter = "mobile/sport-center/filter"
    static let getUpPastTournaments = "mobile/tournament/get/"
    static let filterTournaments = "mobile/tournament/filter"
    static let filterRuns = "mobile/run/filter"
    static let getUpPastRuns = "mobile/run/get/"
    static let updateProfile = "mobile/user/update/profile"
    static let updateEmail = "mobile/user/update/email"
    static let favorite = "mobile/tournament/favourite"
    static let favoriteRuns = "mobile/run/favourite"
    static let initTournamentTransaction = "mobile/tournament/initiate/transaction"
    static let initRunsTransaction = "mobile/run/initiate/transaction"
    static let tournamentRegistration = "mobile/tournament/registration"
    static let runsRegistration = "mobile/run/registration"
    static let uploadRunsGallery = "run/update/gallery"
    static let getRunsGallery = "run/get/gallery"
    static let getTournamentGallery = "tournament/get/gallery"
    static let getTournamentRegistrations = "mobile/tournament/get/user/registration-list"
    static let getRunsRegistrations = "mobile/run/get/user/registration-list"
    static let tournamentRegistrationData = "mobile/tournament/get/user/registration-data"
    static let runRegistrationData = "mobile/run/get/user/registration-data"
    static let cancelTicket = "mobile/tournament/cancel/tournament-ticket"
    static let cancelRunsTicket = "mobile/run/cancel/run-ticket"
    static let tournamentDetails = "mobile/tournament/getById"
    static let runsDetails = "mobile/run/getById"
}

class Webservices {
    
    var base = ""
    var request: Alamofire.Request?
    var progress = KDCircularProgress()
    var progressLabel = UILabel()
    
    enum MimeType:String {
        case pdf = "application/pdf"
        case image = "image/png"
    }
    init() {
        base = baseURL
        guard let view = AppUtilities.getMainWindow() else {return}
        view.viewWithTag(12345)?.removeFromSuperview()
        let bgView = UIView(frame: view.bounds)
        bgView.tag = 12345
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.isHidden = true
        view.addSubview(bgView)
        
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        progress.startAngle = -90
        progress.progressThickness = 0.2
        progress.trackThickness = 0.0
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.glowMode = .forward
        progress.glowAmount = 0.9
        progress.set(colors: UIColor.AppColor.themeColor ?? .clear)
        progress.center = CGPoint(x: bgView.center.x, y: bgView.center.y + 25)
        
        progressLabel = UILabel(frame: progress.bounds)
        progressLabel.text = ""
        progressLabel.textColor = UIColor.white
        progressLabel.textAlignment = .center
        bgView.addSubview(progressLabel)
        progressLabel.center = progress.center
        
        bgView.addSubview(progress)
    }
    
    func request<T:Decodable>(with params:[String:Any], useBase:Bool = true, method:HTTPMethod, endPoint:String, type:T.Type, failer:@escaping FailureBlock, success:@escaping(Any) -> Void) {
        
//        var headers:HTTPHeaders = [:]
////        if(authorization != ""){
//            headers = [.authorization(bearerToken: authorization),
//                       .contentType("application/json")]
////        }
        if useBase{
            base = baseURL + endPoint
        }
        else{
            base = endPoint
        }
        debugPrint("URL : \(base)")
//        debugPrint("Headers : \(headers)")
        debugPrint("Parameters : \(params)")
        
        guard let url = URL(string: base) else {return}
        var request        = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if method == .post{
            do {
                request.httpBody   = try JSONSerialization.data(withJSONObject: params)
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
        }
        AF.request(request).responseDecodable(of: type.self) { response in
            
            if let error = response.error{
                print(error)
                debugPrint(error.localizedDescription)
                failer(error.localizedDescription, nil)
            }
            
            if let data = response.data{
                do{
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    debugPrint(json ?? "")
                    let decoder = JSONDecoder()
                    let resp = try decoder.decode(type, from: data)
                    if let jsn = json as? [String:Any]{
                        if let message = jsn["message"] as? String{
                            if let status = jsn["status"] as? Int, status != 200{
                                failer(message, status)
                                
                            }
                            else{
                                success(resp)
                            }
                        }else{
                            if let status = jsn["status"] as? Int, status != 200{
                                failer("Something went wrong", status)
                            }
                            else{
                                success(resp)
                            }
                        }
                        return
                    }
                    success(resp)
                }
                catch{
                    debugPrint(error)
                    failer(error.localizedDescription, nil)
                }
            }
        }
    }
    
    func upload<T:Decodable>(with params:[String:Any], method:HTTPMethod, endPoint:String, type:T.Type, mimeType:MimeType = .image, showProgress:Bool = false, failer:@escaping FailureBlock, success:@escaping(Any) -> Void){
        
        var headers:HTTPHeaders = [:]
        
        if(authorization != ""){
            headers = [.authorization(bearerToken: authorization)]
        }
        
        base = baseURL + endPoint
        debugPrint("URL : \(base)")
        debugPrint("Headers : \(headers)")
        debugPrint("Parameters : \(params)")
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params{
                if let data = value as? Data/*, key == "image"*/{
                    multipartFormData.append(data, withName: key, fileName: mimeType == .pdf ? "\(Date()).pdf" : "\(Date()).jpg", mimeType: mimeType.rawValue)
                }/*else if let data = value as? Data, key == "video"{
                    multipartFormData.append(data, withName: "file", fileName: "\(Date()).mp4", mimeType: "video/mp4")
                }else if let data = value as? Data, key == "music"{
                    multipartFormData.append(data, withName: "file", fileName: "\(Date()).mp3", mimeType: "audio/mpeg")
                }*/
                else{
                    let data = String(describing: value)
                    multipartFormData.append(Data((data).utf8), withName: key)
                }
            }
        }, to: base, headers: headers)
            .uploadProgress { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
                if showProgress{
                    self.progress.superview?.isHidden = false
                    self.progress.progress = progress.fractionCompleted
                    self.progressLabel.text = String(format: "Uploaded %.0f%%", progress.fractionCompleted*100)
                }
        }
        .downloadProgress { progress in
            print("Download Progress: \(progress.fractionCompleted)")
        }
        .responseDecodable(of: type.self) { response in
            debugPrint("Response: \(response)")
            self.progress.superview?.isHidden = true
            if let error = response.error{
                debugPrint(error.localizedDescription)
                failer(error.localizedDescription, nil)
            }
            if let data = response.data{
                do{
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json ?? "")
                    let decoder = JSONDecoder()
                    let resp = try decoder.decode(type, from: data)
                    if let jsn = json as? [String:Any]{
                        if let message = jsn["message"] as? String{
                            if let status = jsn["status"] as? Int, status != 200{
                                failer(message, status)
                            }
                            else{
                                success(resp)
                            }
                        }else{
                            if let status = jsn["status"] as? Int, status != 200{
                                failer("Something went wrong", status)
                            }
                            else{
                                success(resp)
                            }
                        }
                        return
                    }
                    success(resp)
                }
                catch{
                    debugPrint(error.localizedDescription)
                    failer(error.localizedDescription, nil)
                }
            }
            
        }
    }
    
    func download(with url:String,  loader:Bool = true, downloaded:@escaping(Double) -> Void, success:@escaping(Any) -> Void, failer:@escaping(String) -> Void){
        
        self.request = AF.download(url)
        .downloadProgress { progress in
            downloaded(progress.fractionCompleted)
        }
        .responseData { response in
            if let data = response.value {
                success(data)
            }
            else{
                failer(response.error?.localizedDescription ?? "")
            }
        }
    }
}
