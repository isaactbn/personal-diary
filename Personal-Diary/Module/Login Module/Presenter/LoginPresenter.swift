//
//  LoginPresenter.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

protocol LoginPresenter {
    var router: LoginRouter? { get set }
    var interactor: LoginInteractor? { get set }
    var view: LoginView? { get set }
    
    func onValidation(email: String, password: String)
}

class LoginPresentation: LoginPresenter {
    var router: LoginRouter?
    
    var interactor: LoginInteractor?
     
    var view: LoginView?
    
    func onValidation(email: String, password: String) {
        let validation: CAValidation = BaseValidation()
        if validation.isEmpty(s: email) {
            view?.showError(msg: "Email required.")
        } else if validation.isEmpty(s: password) {
            view?.showError(msg: "Password required.")
        } else if !validation.check(s: email, regex: .email) {
            view?.showError(msg: "Email does not match the format.")
        } else {
            onPostLogin(email: email, password: password)
        }
    }
    
    func onPostLogin(email: String, password: String) {
        view?.onLoading()
        let bodyReq = PostLoginBodyRequest(email: email, password: password)
        interactor?.postLogin(body: bodyReq, onSuccess: { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.view?.onFinishLoading()
                CAPreference.set(value: result.accessToken, forKey: .USER_TOKEN)
                CAPreference.set(value: true, forKey: .kHasLoggedIn)
                self.view?.onSuccessLogin(output: result)
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
