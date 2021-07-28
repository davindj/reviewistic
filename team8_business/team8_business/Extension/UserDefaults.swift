//
//  UserDefault.swift
//  team8_business
//
//  Created by Davin Djayadi on 27/07/21.
//

import Foundation

enum UserDefaultsKey: String{
    case userId
}

enum UserDefaultsError: String, Error{
    case UserNotFound
}

extension UserDefaults{
    func getUserId() throws -> String{
        guard let userId = string(forKey: UserDefaultsKey.userId.rawValue) else {
            throw UserDefaultsError.UserNotFound
        }
        return userId
    }
    
    func setUserId(userId: String){
        set(userId, forKey: UserDefaultsKey.userId.rawValue)
    }
}


