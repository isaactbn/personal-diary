//
//  CreateUpdateEntity.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation

struct PostCreateBodyRequest: Codable {
    let title: String
    let content: String
}

struct CreateBodyResponse: ResponseWithMetaData {
    var data: PostCreateBodyFullResponse??
    
    var id: String?
    var title: String?
    var content: String?
    
    typealias ResponseModel = PostCreateBodyFullResponse?
    
    //MARK: FAILURE RESPONSE
    var message: String?
    var name: String?
    var statusCode: Int?
    var method: String?
    var page: Int?
    var limit: Int?
    var totalData: Int?
}

struct PostCreateBodyFullResponse: Codable {
    
}

struct PostCreateOutput {
    let id: String
    let title: String
    let content: String
}
