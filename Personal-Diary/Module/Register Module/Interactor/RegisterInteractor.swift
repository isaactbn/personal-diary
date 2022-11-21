//
//  RegisterInteractor.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

protocol RegisterInteractor {
    var presenter: RegisterPresenter? { get set }
    
    func postRegister(body: PostRegisterBodyRequest, onSuccess: OnSuccess<PostRegisterOutput>, onFailed: OnFailure)
}

class RegisterInteractors: RegisterInteractor {
    func postRegister(body: PostRegisterBodyRequest, onSuccess: OnSuccess<PostRegisterOutput>, onFailed: OnFailure) {
        if let dict = body.dictionary{
            let req = CARequestService<RegisterBodyResponse>()
            let apiConfig = PostRegisterAPI(parameters: dict)
            req.request(environment: BaseEnvironment(), config: apiConfig, onSuccess: { (response) in
                switch response.handle(){
                case .success(_):
                    let model = PostRegisterOutput(id: response.id ?? "", email: response.email ?? "", username: response.username ?? "")
                    
                    onSuccess?(model)
                case .failure(let err as NSError):
                    if err.domain == "Skip Data" {
                        let model = PostRegisterOutput(id: response.id ?? "", email: response.email ?? "", username: response.username ?? "")
                        
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
    
    var presenter: RegisterPresenter?
}
