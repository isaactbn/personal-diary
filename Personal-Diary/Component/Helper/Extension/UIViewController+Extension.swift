//
//  UIViewController+Extension.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import UIKit

extension UIViewController {
    func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func showNavigationBar() {
        navigationController?.extendedLayoutIncludesOpaqueBars = true
        navigationController?.isNavigationBarHidden = false
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
        }
    }
    
    func backToPreviousVC() {
        if let navigationController = navigationController {
            if navigationController.viewControllers.count <= 2{
                NotificationCenter.default.post(name: Notification.Name("ShowTab"), object: nil)
            }
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func backToRootVC() {
        NotificationCenter.default.post(name: Notification.Name("ShowTab"), object: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func pushVC<V: UIViewController>(_ vc: V) {
        if navigationController?.viewControllers.count ?? 0 > 0{
            NotificationCenter.default.post(name: Notification.Name("ShowTab"), object: nil)
        }
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func dismissVC() {
        if navigationController?.viewControllers.count ?? 0 <= 2{
            NotificationCenter.default.post(name: Notification.Name("ShowTab"), object: nil)
        }
        dismiss(animated: false, completion: nil)
    }
    
    func setupNavBarSquareArrow(title: String = "", color: UIColor = .white, back: (()->Void)? = nil){
        guard let nav = navigationController else {
            
            return
            
        }
        
        nav.navigationBar.tintColor = .white
        nav.navigationBar.barTintColor = .white
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        nav.navigationBar.shadowImage = UIImage()
        extendedLayoutIncludesOpaqueBars = true
        self.title = title
        tabBarController?.tabBar.barTintColor = UIColor.brown
        
        //nav.navigationBar.titleTextAttributes = []
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "WorkSans-Bold", size: 18)]
        let back = navItem(icon: "back-square", color: color, onTap: back ?? backToPreviousVC)
        navigationItem.leftBarButtonItem = back
    }
    
    func setupNavBarSquareArrowWithLogoutBtn(title: String = "", color: UIColor = .white){
        guard let nav = navigationController else {
            return
        }
        
        nav.navigationBar.tintColor = .white
        nav.navigationBar.barTintColor = .white
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        nav.navigationBar.shadowImage = UIImage()
        extendedLayoutIncludesOpaqueBars = true
        self.title = title
        tabBarController?.tabBar.barTintColor = UIColor.brown
        
        //nav.navigationBar.titleTextAttributes = []
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "WorkSans-Bold", size: 18)]
        let back = navItem(icon: "back-square", color: color, onTap: logOut)
        navigationItem.leftBarButtonItem = back
    }
    
    func logOut() {
        CAPreference.set(value: "", forKey: .USER_TOKEN)
        CAPreference.set(value: false, forKey: .kHasLoggedIn)
        
        backToRootVC()
    }
    
    func navItem(icon: String = "", title: String = "", color: UIColor = .white, onTap: (() -> Void)?) -> UIBarButtonItem? {
        if !icon.elementsEqual("") {
            let image = UIImage(named: icon)
            let button = UIButton(type: .custom)
            button.setImage(image, for: .normal)
            button.tapGesture(action: onTap)
            button.setTitle(" \(title)", for: .normal)
            button.setTitleColor(color, for: .normal)
            let item = UIBarButtonItem(customView: button)
            return item
        } else {return nil}
    }
    
    func present<V: UIViewController>(_ vc: V, isFullScreen: Bool = false, isWithNavController: Bool = false, completion: (()->Void)? = nil) {
        if navigationController?.viewControllers.count ?? 0 > 0{
            NotificationCenter.default.post(name: Notification.Name("ShowTab"), object: nil)
        }
        if isWithNavController {
            let navController = UINavigationController(rootViewController: vc)
            if #available(iOS 13.0, *) {
                navController.modalPresentationStyle = isFullScreen ? .fullScreen : .automatic
            }
            present(navController, animated: true, completion: completion)
        } else {
            if #available(iOS 13.0, *) {
                vc.modalPresentationStyle = isFullScreen ? .fullScreen : .automatic
            }
            present(vc, animated: true, completion: completion)
        }
        
    }
}
