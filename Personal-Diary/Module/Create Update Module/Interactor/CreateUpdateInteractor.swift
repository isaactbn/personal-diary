//
//  CreateUpdateInteractor.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation

protocol CreateUpdateInteractor {
    var presenter: CreateUpdatePresenter? { get set }
    
    func postCreate(body: PostCreateBodyRequest, onSuccess: OnSuccess<PostCreateOutput>, onFailed: OnFailure)
    func putUpdate(body: PutUpdateBodyRequest, onSuccess: OnSuccess<PutUpdateOutput>, onFailed: OnFailure)
}

class CreateUpdateInteractors: CreateUpdateInteractor {
    func postCreate(body: PostCreateBodyRequest, onSuccess: OnSuccess<PostCreateOutput>, onFailed: OnFailure) {
        if let dict = body.dictionary{
            let req = CARequestService<CreateBodyResponse>()
            let apiConfig = PostCreateAPI(parameters: dict)
            req.request(environment: BaseEnvironment(), config: apiConfig, onSuccess: { (response) in
                switch response.handle(){
                case .success(_):
                    let model = PostCreateOutput(id: response.id ?? "", title: response.title ?? "", content: response.content ?? "")
                    
                    onSuccess?(model)
                case .failure(let err as NSError):
                    if err.domain == "Skip Data" {
                        let model = PostCreateOutput(id: response.id ?? "", title: response.title ?? "", content: response.content ?? "")
                        
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
    
    func putUpdate(body: PutUpdateBodyRequest, onSuccess: OnSuccess<PutUpdateOutput>, onFailed: OnFailure) {
        if let dict = body.dictionary{
            let req = CARequestService<UpdateBodyResponse>()
            var apiConfig = PutUpdateAPI(parameters: dict)
            apiConfig.path += "/\(body.id)"
            req.request(environment: BaseEnvironment(), config: apiConfig, onSuccess: { (response) in
                switch response.handle(){
                case .success(_):
                    let model = PutUpdateOutput(id: response.id ?? "", title: response.title ?? "", content: response.content ?? "")
                    
                    onSuccess?(model)
                case .failure(let err as NSError):
                    if err.domain == "Skip Data" {
                        let model = PutUpdateOutput(id: response.id ?? "", title: response.title ?? "", content: response.content ?? "")
                        
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
    
    var presenter: CreateUpdatePresenter?
}
