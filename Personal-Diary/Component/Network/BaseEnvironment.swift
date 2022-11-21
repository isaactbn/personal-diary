//
//  BaseEnvironment.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

class BaseEnvironment: APIEnvironment{
        
    var token: String = "Bearer " + (CAPreference.getString(forKey: .USER_TOKEN) ?? "")
    var isConvertedFromSnakeCase: Bool = true
    
    var staging: String = "https://private-anon-9a0ff5d26a-halfwineaid.apiary-mock.com"
    var production: String = "https://private-anon-9a0ff5d26a-halfwineaid.apiary-mock.com"
    var isDebug: Bool = true
}
