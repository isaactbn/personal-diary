//
//  RegisterPresenter.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

protocol RegisterPresenter {
    var router: RegisterRouter? { get set }
    var interactor: RegisterInteractor? { get set }
    var view: RegisterView? { get set }
    
    func onRegisterValidation(email: String, username: String, password: String, passwordConfirmation: String)
}

class RegisterPresentation: RegisterPresenter {
    var router: RegisterRouter?
    
    var interactor: RegisterInteractor?
     
    var view: RegisterView?
    
    func onRegisterValidation(email: String, username: String, password: String, passwordConfirmation: String) {
        let validation: CAValidation = BaseValidation()
        if validation.isEmpty(s: email) {
            view?.showError(msg: "Email required.")
        } else if validation.isEmpty(s: username) {
            view?.showError(msg: "Username required.")
        } else if validation.isEmpty(s: password) {
            view?.showError(msg: "Password required.")
        } else if validation.isEmpty(s: passwordConfirmation) {
            view?.showError(msg: "Password Confirmation required.")
        } else if !validation.check(s: email, regex: .email) {
            view?.showError(msg: "Email does not match the format.")
        } else if !validation.check(s: username, regex: .alphanumeric) {
            view?.showError(msg: "Username does not match the format.")
        } else if !validation.check(s: password, regex: .alphanumeric) {
            view?.showError(msg: "Password does not match the format.")
        } else if !validation.check(s: passwordConfirmation, regex: .alphanumeric) {
            view?.showError(msg: "Password Confirmation does not match the format.")
        } else if password != passwordConfirmation {
            view?.showError(msg: "Password must be the same.")
        } else {
            onPostRegister(email: email, username: username, password: password, passwordConfirmation: passwordConfirmation)
        }
    }
    
    func onPostRegister(email: String, username: String, password: String, passwordConfirmation: String) {
        view?.onLoading()
        let bodyReq = PostRegisterBodyRequest(email: email, username: username, password: password, password_confirmation: passwordConfirmation)
        interactor?.postRegister(body: bodyReq, onSuccess: { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.view?.onFinishLoading()
                self.view?.onSuccessRegister(output: result)
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
