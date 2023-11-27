//
//  Store.swift
//  Fiterit
//
//  Created by Apple on 18/08/18.
//  Copyright © 2018 Gurindercql. All rights reserved.
//

import Foundation

class Store {

    class var authKey: String?
    {
        set{
            Store.saveValue(newValue, .authKey)
        }get{
            return Store.getValue(.authKey) as? String
        }
    }
    
    class var id: Int?
    {
        set{
            Store.saveValue(newValue, .id)
        }get{
            return Store.getValue(.id) as? Int
        }
    }
    
    class var walkThrough: Bool?
    {
        set{
            Store.saveValue(newValue,.walkThrough)
        }get{
            return Store.getValue(.walkThrough) as? Bool ?? false
        }
    }

    class var userDetails: SignUpModel?
    {
        set{
            Store.saveUserDetails(newValue, .userDetails)
            Store.authKey = newValue?.body?.token
        }get{
            return Store.getUserDetails(.userDetails)
        }
    }

    class var autoLogin: Bool
    {
        set{
            Store.saveValue(newValue, .autoLogin)
        }get{
            return Store.getValue(.autoLogin) as? Bool ?? false
        }
    }
    
    class var socialLogin: Bool
    {
        set{
            Store.saveValue(newValue, .isSocial)
        }get{
            return Store.getValue(.isSocial) as? Bool ?? false
        }
    }
    class var deviceToken: String?
    {
        set{
            Store.saveValue(newValue, .deviceToken)
        }
        get{
            return Store.getValue(.deviceToken) as? String
        }
    }
    
    class var startDate: String?
    {
        set{
            Store.saveValue(newValue, .startDate)
        }
        get{
            return Store.getValue(.startDate) as? String
        }
    }
    
    class var phone: String?
    {
        set{
            Store.saveValue(newValue, .phoneNumber)
        }
        get{
            return Store.getValue(.phoneNumber) as? String
        }
    }
    
    class var countryCode: String?
    {
        set{
            Store.saveValue(newValue, .countryCode)
        }
        get{
            return Store.getValue(.countryCode) as? String
        }
    }
    
    class var lat: Double?
    {
        set{
            Store.saveValue(newValue, .lat)
        }get{
            return Store.getValue(.lat) as? Double
        }
    }
    class var long: Double?
    {
        set{
            Store.saveValue(newValue, .long)
        }get{
            return Store.getValue(.long) as? Double
        }
    }
    

    static var remove: DefaultKeys!{
        didSet{
            Store.removeKey(remove)
        }
    }

//MARK:-  Private Functions

    private class func removeKey(_ key: DefaultKeys){
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        if key == .userDetails{
            UserDefaults.standard.removeObject(forKey: DefaultKeys.authKey.rawValue)
        }
        UserDefaults.standard.synchronize()
    }

    private class func saveValue(_ value: Any? ,_ key:DefaultKeys){
        var data: Data?
        if let value = value{
            data = NSKeyedArchiver.archivedData(withRootObject: value)
        }
        UserDefaults.standard.set(data, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }

    private class func saveUserDetails<T: Codable>(_ value: T?, _ key: DefaultKeys){
        var data: Data?
        if let value = value{
            data = try? PropertyListEncoder().encode(value)
        }
        Store.saveValue(data, key)
    }

    private class func getUserDetails<T: Codable>(_ key: DefaultKeys) -> T?{
        if let data = self.getValue(key) as? Data{
            let loginModel = try? PropertyListDecoder().decode(T.self, from: data)
            return loginModel
        }
        return nil
    }

    private class func getValue(_ key: DefaultKeys) -> Any{
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? Data{
            if let value = NSKeyedUnarchiver.unarchiveObject(with: data){
                return value
            }else{
                return ""
            }
        }else{
            return ""
        }
    }
}
