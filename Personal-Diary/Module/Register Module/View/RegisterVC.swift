//
//  RegisterVC.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import UIKit

class RegisterVC: BaseVC, RegisterView {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordConfirmationTF: UITextField!
    @IBOutlet weak var registerButtonView: UIButton!
    @IBOutlet weak var eyeButtonView: UIButton!
    @IBOutlet weak var eyeConfirmationButtonView: UIButton!

    var presenter: RegisterPresenter?
    var isShowPassword: Bool = false
    var isShowPasswordConfirmation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
        setupNavBarSquareArrow(title: "", back: backToPreviousVC)
    }
    
    private func setupView() {
        passwordTF.isSecureTextEntry = true
        passwordConfirmationTF.isSecureTextEntry = true
        cardView.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1), alpha: 0.2, x: -1, y: 1, blur: 4, spread: 0)
        registerButtonView.backgroundColor = UIColor.fromGradientWithDirection(.leftToRight, frame: registerButtonView.frame, colors: [#colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1),#colorLiteral(red: 0.3058823529, green: 0.4235294118, blue: 0.8431372549, alpha: 1)])
    }
    
    @IBAction func eyeButtonAct(_ sender: Any) {
        isShowPassword = !isShowPassword
        passwordTF.isSecureTextEntry = !isShowPassword
        eyeButtonView.setImage(isShowPassword ? #imageLiteral(resourceName: "ic-slash-eye") : #imageLiteral(resourceName: "ic-eye"), for: .normal)
    }
    
    @IBAction func eyeConfirmationButtonAct(_ sender: Any) {
        isShowPasswordConfirmation = !isShowPasswordConfirmation
        passwordConfirmationTF.isSecureTextEntry = !isShowPasswordConfirmation
        eyeConfirmationButtonView.setImage(isShowPasswordConfirmation ? #imageLiteral(resourceName: "ic-slash-eye") : #imageLiteral(resourceName: "ic-eye"), for: .normal)
    }
    
    func onSuccessRegister(output: PostRegisterOutput) {
        showRegisterSuccessPopUp(msg: "Berhasil Registrasi, silahkan login untuk masuk.")
    }
    
    @IBAction func registerButtonAct(_ sender: Any) {
        presenter?.onRegisterValidation(email: emailTF.text ?? "", username: usernameTF.text ?? "", password: passwordTF.text ?? "", passwordConfirmation: passwordConfirmationTF.text ?? "")
    }
}
