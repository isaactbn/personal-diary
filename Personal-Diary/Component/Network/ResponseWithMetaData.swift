//
//  ResponseWithMetaData.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

/// Protocol that handle response
/// If response doesn't have key "data", you just have to extend Codable
public protocol BasicResponse: Codable {
    associatedtype ResponseModel
    var data: ResponseModel? {get set}
}

/// Protocol that handle response with meta data
public protocol ResponseWithMetaData: BasicResponse {
    var message: String? {get set}
    var name: String? {get set}
    var statusCode: Int? {get set}
    var method: String? {get set}
    
    var page: Int? {get set}
    var limit: Int? {get set}
    var totalData: Int? {get set}
}

extension ResponseWithMetaData {
    public func handle() -> Result<ResponseModel, Error> {
        if (statusCode != nil) {
            if 200...299 ~= statusCode! {
                if let data = data {
                    return .success(data)
                }
                else {
                    return .failure(NSError(domain: "Object mapping failed", code: 400, userInfo: nil))
                }
            } else {return .failure(NSError(domain: message!, code: statusCode!, userInfo: nil))}
        } else {
            return .failure(NSError(domain: message ?? "Skip Data", code: statusCode ?? 000, userInfo: nil))
        }
    }
}
