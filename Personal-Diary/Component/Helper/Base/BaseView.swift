//
//  BaseView.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation

protocol BaseView {
    func showError(msg: String)
    func showRegisterSuccessPopUp(msg: String)
    func onLoading()
    func onFinishLoading()
}
