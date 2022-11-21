//
//  LoginAPI.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

struct PostLoginAPI: APISetup {
    var method: HttpMethod = .POST
    
    var path: String = "/auth/login"
    
    var parameters: [String : Any]
    
    init(parameters: [String:Any]) {
        self.parameters = parameters
    }
}
