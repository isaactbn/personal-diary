//
//  RegisterView.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

protocol RegisterView: BaseView {
    var presenter: RegisterPresenter? { get set }
    
    func onSuccessRegister(output: PostRegisterOutput)
}
