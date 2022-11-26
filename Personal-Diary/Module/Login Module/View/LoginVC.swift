//
//  LoginVC.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import UIKit

class LoginVC: BaseVC, LoginView {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var eyeButtonView: UIButton!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var registerDesc: UILabel!
    @IBOutlet weak var loginButtonView: UIButton!
    
    var presenter: LoginPresenter?
    var isShowPassword: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
    }
    
    private func setupView() {
        passwordTF.isSecureTextEntry = true
        cardView.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1), alpha: 0.2, x: -1, y: 1, blur: 4, spread: 0)
        loginButtonView.backgroundColor = UIColor.fromGradientWithDirection(.leftToRight, frame: loginButtonView.frame, colors: [#colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1),#colorLiteral(red: 0.3058823529, green: 0.4235294118, blue: 0.8431372549, alpha: 1)])
        
        let myString: String = "No account? Create one"
        registerDesc.attributedText = myString.customColorString(customText: "Create one", color: #colorLiteral(red: 0.3190954328, green: 0.3190953732, blue: 0.3190953732, alpha: 1), weight: .bold, fontSize: 16.0, isUnderlined: false)
    }
    
    private func setupGesture() {
        registerView.tapGesture{
            let registerRouter = RegisterRouters.start()
            let vc = registerRouter.entry ?? UIViewController()
            self.pushVC(vc)
        }
    }
    
    func onSuccessLogin(output: PostLoginOutput) {
        onLoading()
        let homeRouter = HomeRouters.start()
        let vc = homeRouter.entry ?? UIViewController()
        
        showPopUpWithSpecificVC(msg: "Berhasil Login", vc: vc)
    }
    
    @IBAction func eyeButtonAct(_ sender: Any) {
        isShowPassword = !isShowPassword
        passwordTF.isSecureTextEntry = !isShowPassword
        eyeButtonView.setImage(isShowPassword ? #imageLiteral(resourceName: "ic-slash-eye") : #imageLiteral(resourceName: "ic-eye"), for: .normal)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        presenter?.onValidation(email: emailTF.text ?? "", password: passwordTF.text ?? "")
    }
}
