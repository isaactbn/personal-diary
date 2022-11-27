//
//  CreateUpdateRouter.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation
import UIKit

typealias CreateUpdateEntryPoint = CreateUpdateView & BaseVC

protocol CreateUpdateRouter {
    var entry: CreateUpdateEntryPoint? { get }
    
    static func start(isUpdate: Bool, title: String, content: String, id: String) -> CreateUpdateRouter
}

class CreateUpdateRouters: CreateUpdateRouter {
    var entry: CreateUpdateEntryPoint?
    
    static func start(isUpdate: Bool, title: String, content: String, id: String) -> CreateUpdateRouter {
        let router = CreateUpdateRouters()
        
        // Assign VIP
        var view: CreateUpdateView = CreateUpdateVC()
        var presenter: CreateUpdatePresenter = CreateUpdatePresentation()
        var interactor: CreateUpdateInteractor = CreateUpdateInteractors()
        
        view.presenter = presenter
        view.isUpdate = isUpdate
        view.currentTitle = title
        view.currentContent = content
        view.id = id
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? CreateUpdateEntryPoint
        
        return router
    }
    
}
