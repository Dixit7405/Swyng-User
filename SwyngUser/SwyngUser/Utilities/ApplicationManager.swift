//
//  ApplicationManager.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 15/05/21.
//

import Foundation

class ApplicationManager {
    static var authToken:String?{
        set{
            UserDefaults.standard.set(newValue, forKey: DefaultsManager.DefaultKeys.authToken)
        }
        get{
            
            return UserDefaults.standard.string(forKey: DefaultsManager.DefaultKeys.authToken)
        }
    }
    
    static var profileData:Profile?{
        set{
            if let profile = newValue{
                DefaultsManager.saveData(data: profile, type: Profile.self, key: DefaultsManager.DefaultKeys.userData)
            }
        }
        get{
            
            return DefaultsManager.getData(type: Profile.self, key: DefaultsManager.DefaultKeys.userData)
        }
    }
    
    static let googleApiKey = "AIzaSyCJyUKNCGwglDzBmWhjnTBAUvuRnyMizbY"
    static var googleServerKey = "AIzaSyDKEdiTkUK0O9hwN2NyLjRP2Zwmoul0ths"
    static var firebaseToken = ""
    
}
