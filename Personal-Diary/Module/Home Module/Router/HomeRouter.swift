//
//  HomeRouter.swift
//  Personal-Diary
//
//  Created by Isaac on 11/21/22.
//

import Foundation
import UIKit

typealias HomeEntryPoint = HomeView & BaseVC

protocol HomeRouter {
    var entry: HomeEntryPoint? { get }
    
    static func start() -> HomeRouter
}

class HomeRouters: HomeRouter {
    var entry: HomeEntryPoint?
    
    static func start() -> HomeRouter {
        let router = HomeRouters()
        
        // Assign VIP
        var view: HomeView = HomeVC()
        var presenter: HomePresenter = HomePresentation()
        var interactor: HomeInteractor = HomeInteractors()
        
        view.onLoading()
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? HomeEntryPoint
        
        return router
    }
    
}
