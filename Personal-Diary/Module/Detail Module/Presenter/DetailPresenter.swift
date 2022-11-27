//
//  DetailPresenter.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation

protocol DetailPresenter {
    var router: DetailRouter? { get set }
    var interactor: DetailInteractor? { get set }
    var view: DetailView? { get set }
    var id: String? { get set }
    
    func onGetDiaryDetail(id: String)
    func onPutArchiveDiary(id: String)
    func onPutUnarchiveDiary(id: String)
}

class DetailPresentation: DetailPresenter {
    var id: String?
    
    var router: DetailRouter?
    
    var interactor: DetailInteractor? {
        didSet {
            onGetDiaryDetail(id: id ?? "")
        }
    }
     
    var view: DetailView?
    
    func onGetDiaryDetail(id: String) {
        view?.onLoading()
        let bodyReq = GetDetailBodyRequest()
        interactor?.getDetail(id: id, body: bodyReq, onSuccess: { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.view?.onFinishLoading()
                self.view?.onSuccessGetDetail(output: result)
            }
        }) { (error) in
            DispatchQueue.main.async { [weak self] in
                 guard let self = self else {return}
                self.view?.onFinishLoading()
                self.view?.showError(msg: error)
            }
        }
    }
    
    func onPutArchiveDiary(id: String) {
        view?.onLoading()
        let bodyReq = GetDetailBodyRequest()
        interactor?.putArchived(id: id, body: bodyReq, onSuccess: { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.view?.onFinishLoading()
                self.view?.onSuccessGetDetail(output: result)
            }
        }) { (error) in
            DispatchQueue.main.async { [weak self] in
                 guard let self = self else {return}
                self.view?.onFinishLoading()
                self.view?.showError(msg: error)
            }
        }
    }
    
    func onPutUnarchiveDiary(id: String) {
        view?.onLoading()
        let bodyReq = GetDetailBodyRequest()
        interactor?.putUnarchived(id: id, body: bodyReq, onSuccess: { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.view?.onFinishLoading()
                self.view?.onSuccessGetDetail(output: result)
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
