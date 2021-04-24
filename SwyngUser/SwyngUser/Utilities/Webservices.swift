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
let baseURL = "http://goocab.com/admin/User_Apis/"
let imageBase = "http://goocab.com/admin/"

typealias FailureBlock = ((String) -> Void)

struct Parameters {
    static let key = "key"
    static let name = "name"
    static let last_name = "last_name"
    static let gender = "gender"
    static let dob = "dob"
    static let mobile = "mobile"
    static let email = "email"
    static let image = "image"
    static let otp = "otp"
    static let token = "tokan"
    static let userId = "user_id"
    static let id = "id"
    static let chatText = "chattext"
    static let lat = "lat"
    static let long = "longs"
    static let radius = "radius"
    static let vehicleType = "vehicle_type"
    static let vahiclType = "vahicl_type"
    static let coupons = "coupons"
    static let fromDate = "from_date"
    static let fromLocation = "from_location"
    static let fromLat = "from_latitude"
    static let fromLong = "from_longitude"
    static let toLocation = "to_location"
    static let toLat = "to_latitude"
    static let toLong = "to_longitude"
    static let coupon = "coupon"
    static let couponPrice = "coupon_price"
    static let paymentId = "payment_id"
    static let paymentType = "payment_type"
    static let totalDistance = "total_distance"
    static let customerId = "bookedby_customer_id"
    static let cost = "cost"
    static let status = "status"
    static let totalTime = "total_time"
    static let walletAmount = "wallet_amount"
    static let accessAmount = "access_amount"
    static let gstAmount = "gst_amount"
    static let bookingId = "booking_id"
    static let review = "review"
    static let rating = "rating"
}

struct EndPoints {
    static let registerUser = "user_register_api"
    static let matchOTP = "user_otp_match_api"
    static let login = "user_login_api"
    static let fetchUser = "user_fetch_api"
    static let updateUser = "user_edit_api"
    static let fetchWallet = "user_wallet"
    static let fetchSOS = "user_sos"
    static let addSOS = "user_sos_add"
    static let deleteSOS = "user_sos_delete"
    static let fetchChat = "chat_fetch"
    static let sendMessage = "chat_add"
    static let userFAQs = "user_faqs"
    static let tripHistory = "user_history"
    static let fetchNotification = "user_notification"
    static let getAllTypeVehicle = "available_near_by_me"
    static let getSelectedVehicle = "available_near_by_vehicle"
    static let getCoupons = "get_coupons_list"
    static let checkCoupon = "get_coupons_check"
    static let bookingAPI = "booking_api"
    static let cancelBooking = "cancel_booking"
    static let privacy = "user_privacy"
    static let terms = "user_terms"
    static let getRunningBookings = "get_running_bookings"
    static let userRating = "user_rating"
}

class Webservices {
    var base = ""
    var request: Alamofire.Request?
    var progress = KDCircularProgress()
    var progressLabel = UILabel()
    init() {
        base = baseURL
        guard let view = AppUtilities.shared().getMainWindow() else {return}
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
        request.httpMethod = "POST"
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody   = try JSONSerialization.data(withJSONObject: params)
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        AF.request(request).responseDecodable(of: type.self) { response in
            
            if response.response?.statusCode == 400, let data = response.data{
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any], let data = json["data"] as? [String:Any]{
                    debugPrint(json)
                    for (_,value) in data{
                        if let val = value as? [String], let str = val.first{
                            failer(str)
                            break
                        }
                    }
                }
                return
            }
            if let error = response.error{
                print(error)
                debugPrint(error.localizedDescription)
                failer(error.localizedDescription)
            }
            
            if let data = response.data{
                do{
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    debugPrint(json ?? "")
                    let decoder = JSONDecoder()
                    let resp = try decoder.decode(type, from: data)
                    if let jsn = json as? [String:Any]{
                        if let message = jsn["message"] as? String{
                            if let status = jsn["status"] as? String, status == "0"{
                                failer(message)
                            }
                            else{
                                success(resp)
                            }
                        }else{
                            if let status = jsn["status"] as? String, status == "0"{
                                failer("Something went wrong")
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
                    failer(error.localizedDescription)
                }
            }
        }
    }
    
    func upload<T:Decodable>(with params:[String:Any], method:HTTPMethod, endPoint:String, type:T.Type, showProgress:Bool = false, failer:@escaping(String) -> Void, success:@escaping(Any) -> Void){
        
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
                if let data = value as? Data, key == "image"{
                    multipartFormData.append(data, withName: key, fileName: "\(Date()).jpg", mimeType: "image/png")
                }else if let data = value as? Data, key == "video"{
                    multipartFormData.append(data, withName: "file", fileName: "\(Date()).mp4", mimeType: "video/mp4")
                }else if let data = value as? Data, key == "music"{
                    multipartFormData.append(data, withName: "file", fileName: "\(Date()).mp3", mimeType: "audio/mpeg")
                }
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
            if response.response?.statusCode == 400, let data = response.data{
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
                    for (_,value) in json{
                        if let val = value as? [String], let str = val.first{
                            failer(str)
                            break
                        }
                    }
                }
                return
            }
            if let error = response.error{
                debugPrint(error.localizedDescription)
                failer(error.localizedDescription)
            }
            if let data = response.data{
                do{
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json ?? "")
                    let decoder = JSONDecoder()
                    let resp = try decoder.decode(type, from: data)
                    success(resp)
                }
                catch{
                    debugPrint(error.localizedDescription)
                    failer(error.localizedDescription)
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
