//
//  LoginInteractor.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

protocol LoginInteractor {
    var presenter: LoginPresenter? { get set }
    
    func postLogin()
    func postLogin(body: PostLoginBodyRequest, onSuccess: OnSuccess<PostLoginOutput>, onFailed: OnFailure)
}

class LoginInteractors: LoginInteractor {
    func postLogin(body: PostLoginBodyRequest, onSuccess: OnSuccess<PostLoginOutput>, onFailed: OnFailure) {
        if let dict = body.dictionary{
            let req = CARequestService<LoginBodyResponse>()
            let apiConfig = PostLoginAPI(parameters: dict)
            req.request(environment: BaseEnvironment(), config: apiConfig, onSuccess: { (response) in
                switch response.handle(){
                case .success(_):
                    let model = PostLoginOutput(id: response.user?.id ?? "", email: response.user?.email ?? "", username: response.user?.username ?? "", accessToken: response.accessToken ?? "")
                    
                    onSuccess?(model)
                case .failure(let err as NSError):
                    if err.domain == "Skip Data" {
                        let model = PostLoginOutput(id: response.user?.id ?? "", email: response.user?.email ?? "", username: response.user?.username ?? "", accessToken: response.accessToken ?? "")
                        
                        onSuccess?(model)
                    } else {
                        onFailed?(err.domain)
                    }
                }
            }) { (error) in
                onFailed?(error)
            }
        }
    }
    
    var presenter: LoginPresenter?
    
    func postLogin() {
        
    }
}
