//
//  RegisterRouter.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation
import UIKit

typealias RegisterEntryPoint = RegisterView & BaseVC

protocol RegisterRouter {
    var entry: RegisterEntryPoint? { get }
    
    static func start() -> RegisterRouter
}

class RegisterRouters: RegisterRouter {
    var entry: RegisterEntryPoint?
    
    static func start() -> RegisterRouter {
        let router = RegisterRouters()
        
        // Assign VIP
        var view: RegisterView = RegisterVC()
        var presenter: RegisterPresenter = RegisterPresentation()
        var interactor: RegisterInteractor = RegisterInteractors()
        
        view.onLoading()
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? RegisterEntryPoint
        
        return router
    }
    
}
