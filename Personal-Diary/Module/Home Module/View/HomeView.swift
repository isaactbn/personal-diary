//
//  HomeView.swift
//  Personal-Diary
//
//  Created by Isaac on 11/21/22.
//

import Foundation

protocol HomeView: BaseView {
    var presenter: HomePresenter? { get set }
    
    func onSuccessHomeData(output: GetHomeOutput)
}
