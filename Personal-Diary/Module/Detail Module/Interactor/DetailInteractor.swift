//
//  DetailInteractor.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation

protocol DetailInteractor {
    var presenter: DetailPresenter? { get set }
    
    func getDetail(id: String, body: GetDetailBodyRequest, onSuccess: OnSuccess<GetDetailOutput>, onFailed: OnFailure)
    func putArchived(id: String, body: GetDetailBodyRequest, onSuccess: OnSuccess<GetDetailOutput>, onFailed: OnFailure)
    func putUnarchived(id: String, body: GetDetailBodyRequest, onSuccess: OnSuccess<GetDetailOutput>, onFailed: OnFailure)
}

class DetailInteractors: DetailInteractor {
    func getDetail(id: String, body: GetDetailBodyRequest, onSuccess: OnSuccess<GetDetailOutput>, onFailed: OnFailure) {
        if let dict = body.dictionary{
            let req = CARequestService<DetailBodyResponse>()
            var apiConfig = GetDetailAPI(parameters: dict)
            apiConfig.path += "/\(id)"
            req.request(environment: BaseEnvironment(), config: apiConfig, onSuccess: { (response) in
                switch response.handle(){
                case .success(_):
                    let model = GetDetailOutput(id: response.id ?? "", title: response.title ?? "", content: response.content ?? "", isArchieved: response.isArchieved ?? false, createdAt: response.createdAt ?? "", updatedAt: response.updatedAt ?? "")
                    
                    onSuccess?(model)
                case .failure(let err as NSError):
                    if err.domain == "Skip Data" {
                        let model = GetDetailOutput(id: response.id ?? "", title: response.title ?? "", content: response.content ?? "", isArchieved: response.isArchieved ?? false, createdAt: response.createdAt ?? "", updatedAt: response.updatedAt ?? "")
                        
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
    
    func putArchived(id: String, body: GetDetailBodyRequest, onSuccess: OnSuccess<GetDetailOutput>, onFailed: OnFailure) {
        if let dict = body.dictionary{
            let req = CARequestService<DetailBodyResponse>()
            var apiConfig = PutArchivedAPI(parameters: dict)
            apiConfig.path += "/\(id)/archieve"
            req.request(environment: BaseEnvironment(), config: apiConfig, onSuccess: { (response) in
                switch response.handle(){
                case .success(_):
                    let model = GetDetailOutput(id: response.id ?? "", title: response.title ?? "", content: response.content ?? "", isArchieved: response.isArchieved ?? false, createdAt: response.createdAt ?? "", updatedAt: response.updatedAt ?? "")
                    
                    onSuccess?(model)
                case .failure(let err as NSError):
                    if err.domain == "Skip Data" {
                        let model = GetDetailOutput(id: response.id ?? "", title: response.title ?? "", content: response.content ?? "", isArchieved: response.isArchieved ?? false, createdAt: response.createdAt ?? "", updatedAt: response.updatedAt ?? "")
                        
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
    
    func putUnarchived(id: String, body: GetDetailBodyRequest, onSuccess: OnSuccess<GetDetailOutput>, onFailed: OnFailure) {
        if let dict = body.dictionary{
            let req = CARequestService<DetailBodyResponse>()
            var apiConfig = PutArchivedAPI(parameters: dict)
            apiConfig.path += "/\(id)/unarchieve"
            req.request(environment: BaseEnvironment(), config: apiConfig, onSuccess: { (response) in
                switch response.handle(){
                case .success(_):
                    let model = GetDetailOutput(id: response.id ?? "", title: response.title ?? "", content: response.content ?? "", isArchieved: response.isArchieved ?? false, createdAt: response.createdAt ?? "", updatedAt: response.updatedAt ?? "")
                    
                    onSuccess?(model)
                case .failure(let err as NSError):
                    if err.domain == "Skip Data" {
                        let model = GetDetailOutput(id: response.id ?? "", title: response.title ?? "", content: response.content ?? "", isArchieved: response.isArchieved ?? false, createdAt: response.createdAt ?? "", updatedAt: response.updatedAt ?? "")
                        
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
    
    var presenter: DetailPresenter?
}
