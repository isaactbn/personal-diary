//
//  APISetup.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation
public protocol APISetup {
    var method: HttpMethod {get}
    var path: String {get}
    var parameters: [String:Any] {get}
}

extension APISetup {
    func setupRequest(environment: APIEnvironment) -> URLRequest {
        let url = "\(environment.setupUrl().absoluteString)\(path)"
        let finalUrl = URL(string: url)!
        
        var request = finalUrl.setParameter(parameters: parameters, method: method)
        
        request.setHeader(token: environment.token)
        request.httpMethod = method.rawValue
        if environment.isDebug { logRequest(withRequest: request) }
        
        return request
    }
    
    func logRequest(withRequest request: URLRequest) {
        print("HEADER = \(String(describing: request.allHTTPHeaderFields))")
        print("BODY = \(String(describing: request.httpBody))")
        print("URL = \(String(describing: request.url?.absoluteString))")
        print("METHOD = \(request.httpMethod ?? "NONE")")
    }
}
