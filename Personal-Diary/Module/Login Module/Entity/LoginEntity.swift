//
//  LoginEntity.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

struct PostLoginBodyRequest: Codable {
    let email: String
    let password: String
}

struct LoginBodyResponse: ResponseWithMetaData {
    var data: PostLoginBodyFullResponse??
    
    var user: PostLoginBodyFullResponse?
    
    typealias ResponseModel = PostLoginBodyFullResponse?
    
    var accessToken: String?
    
    //MARK: FAILURE RESPONSE
    var message: String?
    var name: String?
    var statusCode: Int?
    var method: String?
    var page: Int?
    var limit: Int?
    var totalData: Int?
}

struct PostLoginBodyFullResponse: Codable {
    let id: String?
    let email: String?
    let username: String?
}

struct PostLoginOutput {
    let id: String
    let email: String
    let username: String
    var accessToken: String
}
