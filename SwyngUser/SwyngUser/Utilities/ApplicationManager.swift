//
//  ApplicationManager.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 15/05/21.
//

import Foundation

enum SportType {
    case tournaments
    case run
}

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
    
    static var firebaseToken = ""
    
    
    static var sportType:SportType?{
        set{
            if let sport = newValue{
                UserDefaults.standard.setValue(sport == .tournaments ? 1 : 2, forKey: DefaultsManager.DefaultKeys.sportType)
            }
        }
        get{
            if let type = UserDefaults.standard.value(forKey: DefaultsManager.DefaultKeys.sportType) as? Int{
                return type == 1 ? .tournaments : .run
            }
            return .tournaments
        }
    }
    
    static var cityId:Int?{
        set{
            if let cityId = newValue{
                UserDefaults.standard.setValue(cityId, forKey: DefaultsManager.DefaultKeys.cityId)
            }
        }
        get{
            if let id = UserDefaults.standard.value(forKey: DefaultsManager.DefaultKeys.cityId) as? Int{
                return id
            }
            return nil
        }
    }
    
    static var selectedCity:City?{
        set{
            guard let city = newValue else {return}
            DefaultsManager.saveData(data: city, type: City.self, key: DefaultsManager.DefaultKeys.selectedCity)
        }
        get{
            return DefaultsManager.getData(type: City.self, key: DefaultsManager.DefaultKeys.selectedCity)
        }
    }
    
    static var selectedSport:Sports?{
        set{
            if let sport = newValue{
                DefaultsManager.saveData(data: sport, type: Sports.self, key: DefaultsManager.DefaultKeys.selectedSport)
            }
        }
        get{
            DefaultsManager.getData(type: Sports.self, key: DefaultsManager.DefaultKeys.selectedSport)
        }
    }
    
    static var selectedCenter:SportCenters?{
        set{
            if let center = newValue{
                DefaultsManager.saveData(data: center, type: SportCenters.self, key: DefaultsManager.DefaultKeys.selectedCenter)
            }
        }
        get{
            DefaultsManager.getData(type: SportCenters.self, key: DefaultsManager.DefaultKeys.selectedCenter)
        }
    }
    
    static var tournament:Tournaments?
    static var runs:Run?
}
