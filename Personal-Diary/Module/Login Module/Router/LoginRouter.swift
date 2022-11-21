//
//  LoginRouter.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation
import UIKit

typealias EntryPoint = LoginView & BaseVC

protocol LoginRouter {
    var entry: EntryPoint? { get }
    
    static func start() -> LoginRouter
}

class LoginRouters: LoginRouter {
    var entry: EntryPoint?
    
    static func start() -> LoginRouter {
        let router = LoginRouters()
        
        // Assign VIP
        var view: LoginView = LoginVC()
        var presenter: LoginPresenter = LoginPresentation()
        var interactor: LoginInteractor = LoginInteractors()
        
//        view.onLoading()
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
}
