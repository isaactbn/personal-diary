//
//  CreateUpdateAPI.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation

struct PostCreateAPI: APISetup {
    var method: HttpMethod = .POST
    
    var path: String = "/diary"
    
    var parameters: [String : Any]
    
    init(parameters: [String:Any]) {
        self.parameters = parameters
    }
}

struct PutUpdateAPI: APISetup {
    var method: HttpMethod = .PUT
    
    var path: String = "/diary"
    
    var parameters: [String : Any]
    
    init(parameters: [String:Any]) {
        self.parameters = parameters
    }
}
