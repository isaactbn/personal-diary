//
//  HomeInteractor.swift
//  Personal-Diary
//
//  Created by Isaac on 11/21/22.
//

import Foundation

protocol HomeInteractor {
    var presenter: HomePresenter? { get set }
    
    func getHome(body: GetHomeBodyRequest, onSuccess: OnSuccess<GetHomeOutput>, onFailed: OnFailure)
}

class HomeInteractors: HomeInteractor {
    func getHome(body: GetHomeBodyRequest, onSuccess: OnSuccess<GetHomeOutput>, onFailed: OnFailure) {
        if let dict = body.dictionary{
            let req = CARequestService<HomeBodyResponse>()
            let apiConfig = GetHomeAPI(parameters: dict)
            req.request(environment: BaseEnvironment(), config: apiConfig, onSuccess: { (response) in
                switch response.handle(){
                case .success(_):
                    var model: [GetHomeBodyFullResponse] = []
                    
                    response.data??.forEach{(data) in
                        var data = GetHomeBodyFullResponse(id: data.id, title: data.title, content: data.content, isArchieved: data.isArchieved, createdAt: data.createdAt, updatedAt: data.updatedAt)
                        model.append(data)
                    }
                    
                    let newModel = GetHomeOutput(data: model, page: response.page ?? 0, limit: response.limit ?? 0, totalData: response.totalData ?? 0)
                    
                    onSuccess?(newModel)
                case .failure(let err as NSError):
                    if err.domain == "Skip Data" {
                        var model: [GetHomeBodyFullResponse] = []
                        
                        response.data??.forEach{(data) in
                            var data = GetHomeBodyFullResponse(id: data.id, title: data.title, content: data.content, isArchieved: data.isArchieved, createdAt: data.createdAt, updatedAt: data.updatedAt)
                            model.append(data)
                        }
                        
                        let newModel = GetHomeOutput(data: model, page: response.page ?? 0, limit: response.limit ?? 0, totalData: response.totalData ?? 0)
                        
                        onSuccess?(newModel)
                    } else {
                        onFailed?(err.domain)
                    }
                }
            }) { (error) in
                onFailed?(error)
            }
        }
    }
    
    var presenter: HomePresenter?
}
