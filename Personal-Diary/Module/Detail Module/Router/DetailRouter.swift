//
//  DetailRouter.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation

import UIKit

typealias DetailEntryPoint = DetailView & BaseVC

protocol DetailRouter {
    var entry: DetailEntryPoint? { get }
    
    static func start(id: String) -> DetailRouter
}

class DetailRouters: DetailRouter {
    var entry: DetailEntryPoint?
    
    static func start(id: String) -> DetailRouter {
        let router = DetailRouters()
        
        // Assign VIP
        var view: DetailView = DetailVC()
        var presenter: DetailPresenter = DetailPresentation()
        var interactor: DetailInteractor = DetailInteractors()
        
        presenter.id = id
        
        view.onLoading()
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? DetailEntryPoint
        
        return router
    }
    
}
