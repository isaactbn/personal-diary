//
//  RegisterEntity.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

struct PostRegisterBodyRequest: Codable {
    let email: String
    let username: String
    let password: String
    let password_confirmation: String
}

struct RegisterBodyResponse: ResponseWithMetaData {
    var data: PostRegisterBodyFullResponse??
    
    let id: String?
    let email: String?
    let username: String?
    
    typealias ResponseModel = PostRegisterBodyFullResponse?
    
    //MARK: FAILURE RESPONSE
    var message: String?
    var name: String?
    var statusCode: Int?
    var method: String?
    var page: Int?
    var limit: Int?
    var totalData: Int?
}

struct PostRegisterBodyFullResponse: Codable {
}

struct PostRegisterOutput {
    let id: String
    let email: String
    let username: String
}
