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
let imageBase = "http://goocab.com/admin/"

typealias FailureBlock = ((String) -> Void)

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
}

struct EndPoints {
    static let registerUser = "account/user/signup"
    static let getCities = "city/getAll"
    static let sendOTP = "account/user/otp/send"
    static let resendOTP = "account/user/otp/resend"
    static let verifyOTP = "account/user/otp/verify"
    static let getProfile = "account/user/getProfile"
    static let updateProfile = "account/user/updateProfile"
    static let getTournaments = "tournament/getAll"
}

class Webservices {
    var base = ""
    var request: Alamofire.Request?
    var progress = KDCircularProgress()
    var progressLabel = UILabel()
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
