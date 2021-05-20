//
//  DefaultsManager.swift
//  MyTremolo Teacher
//
//  Created by Dixit Rathod on 25/10/20.
//

import Foundation

class DefaultsManager{
    struct DefaultKeys {
        static let userData = "UserData"
        static let authToken = "authToken"
        static let isLoggedIn = "IsLoggedIn"
    }
//    
//    static var userData:Register?{
//        get{
//            return DefaultsManager.getData(type: Register.self, key: DefaultKeys.userData)
//        }
//    }
    
    
    class func saveData<T:Codable>(data:T, type:T.Type, key:String){
        do {
            let encoder = JSONEncoder()
            guard let dt = try? encoder.encode(data) else {return}
            if let json = try JSONSerialization.jsonObject(with: dt, options: .allowFragments) as? [String:Any]{
                UserDefaults.standard.setValue(json, forKey: key)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func getData<T:Codable>(type:T.Type, key:String) -> T?{
        do {
            let decoder = JSONDecoder()
            guard let json = UserDefaults.standard.value(forKey: key) else {return nil}
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return try decoder.decode(type, from: data)
        } catch  {
            print("Error")
        }
        return nil
    }
    
    
}
