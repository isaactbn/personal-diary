//
//  BaseView.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation
import UIKit

protocol BaseView {
    func showError(msg: String)
    func showPopUpWithSpecificVC(msg: String, vc: UIViewController)
    func onLoading()
    func onFinishLoading()
}
