//
//  HomePresenter.swift
//  Personal-Diary
//
//  Created by Isaac on 11/21/22.
//

import Foundation

protocol HomePresenter {
    var router: HomeRouter? { get set }
    var interactor: HomeInteractor? { get set }
    var view: HomeView? { get set }
    
    func onGetDiaryList(search: String)
}

class HomePresentation: HomePresenter {
    var router: HomeRouter?
    
    var interactor: HomeInteractor? {
        didSet {
            onGetDiaryList(search: "")
        }
    }
     
    var view: HomeView?
    
    func onGetDiaryList(search: String) {
        view?.onLoading()
        let bodyReq = GetHomeBodyRequest(search: search)
        interactor?.getHome(body: bodyReq, onSuccess: { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.view?.onFinishLoading()
                self.view?.onSuccessHomeData(output: result)
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
