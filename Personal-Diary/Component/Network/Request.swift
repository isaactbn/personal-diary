//
//  Request.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation
public typealias OnSuccess<T> = ((T)->Void)?
public typealias OnFailure = ((String)->Void)?

/// An object that responsible for requesting remote data
/// - Parameters:
///   - T: response object and should extends Codable
open class CARequestService<T: Codable> {
    
    public init() {
        
    }
    
    /// Request remote data
    /// - Parameters:
    ///   - environment: determine the environment for base URL
    ///   - config: request blueprint for API setup
    ///   - onSuccess: retrieve model from response
    ///   - onFailure: retrieve error from response
    public func request(environment: APIEnvironment, config: APISetup, onSuccess: OnSuccess<T>, onFailure: OnFailure) {
        let _request = config.setupRequest(environment: environment)
        let task = URLSession.shared.dataTask(with: _request, completionHandler: { (data, _, _) in
            let result = self.setupResult(data: data, env: environment)
            switch result {
            case .success(let model):
                onSuccess?(model)
            case .failure(let err):
                onFailure?(err.localizedDescription)
            }
        })
        task.resume()
    }
    
    func setupResult(data: Data?, env: APIEnvironment) -> Result<T, Error> {
        if Reachability.isConnectedToNetwork() {
            do {
                let decoder = env.decoder()
                let model: T = try decoder.decode(T.self, from: data ?? Data())
                return .success(model)
            } catch {
                return .failure(error)
            }
        } else {
            let error: Error = NSError(domain: "Failed to connect to the internet. Check your internet connection", code: 523, userInfo: nil)
            return .failure(error)
        }
    }
    
    /// Download image
    /// - Parameters:
    ///   - url: url path
    ///   - completion: callback from the request, whether it's success or failure
    public func downloadImage(from url: URL, completion: ((Result<Data, Error>)->Void)?) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err { completion?(.failure(err)) }
            if let data = data { completion?(.success(data)) }
        }
        task.resume()
    }
}

extension URL {
    /// Setup request body or query
    /// - Parameters:
    ///   - parameters: body or query
    ///   - method: HTTP method
    func setParameter(parameters: [String: Any], method: HttpMethod) -> URLRequest {
        switch method {
        case .GET:
            var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
            var queryItems: [URLQueryItem] = []
            for key in parameters.keys {
                queryItems.append(URLQueryItem(name: key, value: "\(parameters[key]!)"))
            }
            urlComponents.queryItems = queryItems
            urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            return URLRequest(url: urlComponents.url!)
        default:
            var request = URLRequest(url: self)
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            return request
        }
    }
}

extension URLRequest {
    /// Set header for API request
    /// - Parameter auth: authentication for getting token from UseDefaults
    mutating func setHeader(token: String) {
        if !token.isEmpty { addValue(token, forHTTPHeaderField: "Authorization") }
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        addValue("application/json", forHTTPHeaderField: "accept")
    }
}
