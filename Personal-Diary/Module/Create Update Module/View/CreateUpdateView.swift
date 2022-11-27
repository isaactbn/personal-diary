//
//  CreateUpdateView.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation

protocol CreateUpdateView: BaseView {
    var presenter: CreateUpdatePresenter? { get set }
    var isUpdate: Bool {get set}
    var currentTitle: String {get set}
    var currentContent: String {get set}
    var id: String {get set}
    
    func onSuccessPostCreate(output: PostCreateOutput)
    func onSuccessPutUpdate(output: PutUpdateOutput)
}
