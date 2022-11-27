//
//  GetDetailAPI.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation

struct GetDetailAPI: APISetup {
    var method: HttpMethod = .GET
    
    var path: String = "/diary"
    
    var parameters: [String : Any]
    
    init(parameters: [String:Any]) {
        self.parameters = parameters
    }
}
