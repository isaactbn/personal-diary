//
//  HomeEntity.swift
//  Personal-Diary
//
//  Created by Isaac on 11/21/22.
//

import Foundation

struct GetHomeBodyRequest: Codable {
    let search: String
}

struct HomeBodyResponse: ResponseWithMetaData {
    var data: [GetHomeBodyFullResponse]??
    
    typealias ResponseModel = [GetHomeBodyFullResponse]?
    
    //MARK: FAILURE RESPONSE
    var message: String?
    var name: String?
    var statusCode: Int?
    var method: String?
    var page: Int?
    var limit: Int?
    var totalData: Int?
}

struct GetHomeBodyFullResponse: Codable {
    let id: String
    let title: String
    let content: String
    let isArchieved: Bool
    let createdAt: String
    let updatedAt: String
}

struct GetHomeOutput {
    let data: [GetHomeBodyFullResponse]
    var page: Int
    var limit: Int
    var totalData: Int
}
