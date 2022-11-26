//
//  BaseVC.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import Foundation
import ProgressHUD

class BaseVC: UIViewController {
    private let loadingView: UIView = UIView()
//    private let loginRouter = LoginRouters.start()
//    private let rootVC = loginRouter.entry ?? UIViewController()
    
    override func viewDidLoad() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = navigationController?.viewControllers.count ?? 0 > 1
    }
}

extension BaseVC: UIGestureRecognizerDelegate{
}

extension BaseVC: BaseView {
    func showError(msg: String) {
            let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
    }
    
    func showPopUpWithSpecificVC(msg: String, vc: UIViewController) {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
            if vc != LoginVC() {
                self.pushVC(vc)
            } else {
                self.backToRootVC()
            }
        }))
        self.present(alert, animated: true)
    }
    
    func onLoading() {
        showLoading()
    }
    
    private func showLoading() {
        ProgressHUD.colorHUD = .clear
        ProgressHUD.colorBackground = .clear
        ProgressHUD.show()
    }
    
    func onFinishLoading() {
        hideLoading()
    }
    
    private func hideLoading() {
        ProgressHUD.dismiss()
    }
}
