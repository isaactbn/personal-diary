//
//  CreateUpdatePresenter.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation

protocol CreateUpdatePresenter {
    var router: CreateUpdateRouter? { get set }
    var interactor: CreateUpdateInteractor? { get set }
    var view: CreateUpdateView? { get set }
    
    func onCreateUpdateValidation(title: String, content: String, isUpdate: Bool, id: String)
}

class CreateUpdatePresentation: CreateUpdatePresenter {
    var router: CreateUpdateRouter?
    
    var interactor: CreateUpdateInteractor?
     
    var view: CreateUpdateView?
    
    func onCreateUpdateValidation(title: String, content: String, isUpdate: Bool, id: String) {
        let validation: CAValidation = BaseValidation()
        if validation.isEmpty(s: title) {
            view?.showError(msg: "Title required.")
        } else if validation.isEmpty(s: content) {
            view?.showError(msg: "Content required.")
        } else {
            if isUpdate {
                putUpdateDiaryList(title: title, content: content, id: id)
            } else {
                postCreateDiaryList(title: title, content: content)
            }
        }
    }
    
    func postCreateDiaryList(title: String, content: String) {
        view?.onLoading()
        let bodyReq = PostCreateBodyRequest(title: title, content: content)
        interactor?.postCreate(body: bodyReq, onSuccess: { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.view?.onFinishLoading()
                self.view?.onSuccessPostCreate(output: result)
            }
        }) { (error) in
            DispatchQueue.main.async { [weak self] in
                 guard let self = self else {return}
                self.view?.onFinishLoading()
                self.view?.showError(msg: error)
            }
        }
    }
    
    func putUpdateDiaryList(title: String, content: String, id: String) {
        view?.onLoading()
        let bodyReq = PutUpdateBodyRequest(id: id, title: title, content: content)
        interactor?.putUpdate(body: bodyReq, onSuccess: { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.view?.onFinishLoading()
                self.view?.onSuccessPutUpdate(output: result)
            }
        }) { (error) in
            DispatchQueue.main.async { [weak self] in
                 guard let self = self else {return}
                self.view?.onFinishLoading()
                self.view?.showError(msg: error)
            }
        }
    }
}
