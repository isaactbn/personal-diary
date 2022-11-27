//
//  DetailEntity.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation

struct GetDetailBodyRequest: Codable {
}

struct DetailBodyResponse: ResponseWithMetaData {
    var data: GetDetailBodyFullResponse??
    
    typealias ResponseModel = GetDetailBodyFullResponse?
    
    var id: String?
    var title: String?
    var content: String?
    var isArchieved: Bool?
    var createdAt: String?
    var updatedAt: String?
    
    //MARK: FAILURE RESPONSE
    var message: String?
    var name: String?
    var statusCode: Int?
    var method: String?
    var page: Int?
    var limit: Int?
    var totalData: Int?
}

struct GetDetailBodyFullResponse: Codable {
}

struct GetDetailOutput {
    let id: String
    let title: String
    let content: String
    let isArchieved: Bool
    let createdAt: String
    let updatedAt: String
}
