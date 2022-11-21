//
//  LoginView.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

protocol LoginView: BaseView {
    var presenter: LoginPresenter? { get set }
    
    func onSuccessLogin(output: PostLoginOutput)
}
