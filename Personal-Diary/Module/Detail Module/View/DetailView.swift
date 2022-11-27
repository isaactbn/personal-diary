//
//  DetailView.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import Foundation

protocol DetailView: BaseView {
    var presenter: DetailPresenter? { get set }
    
    func onSuccessGetDetail(output: GetDetailOutput)
}
