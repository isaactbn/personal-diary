//
//  CreateUpdateVC.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import UIKit

class CreateUpdateVC: BaseVC, CreateUpdateView {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var createUpdateButtonView: UIButton!
    
    var presenter: CreateUpdatePresenter?
    var isUpdate: Bool = false
    var currentTitle: String = ""
    var currentContent: String = ""
    var id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let setTitle = isUpdate ? "Update" : "Create"
        showNavigationBar()
        setupNavBarSquareArrow(title: "\(setTitle) Diary Note")
    }
    
    private func setupView() {
        contentTextView.setupRadius(type: .custom(12))
        contentTextView.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1), alpha: 0.2, x: -1, y: 1, blur: 4, spread: 0)
        
        createUpdateButtonView.setTitle(isUpdate ? "Update" : "Create", for: .normal)
    }
    
    private func setupData() {
        if isUpdate {
            titleTF.text = currentTitle
            contentTextView.text = currentContent
        }
    }
    
    private func backToHomePage() {
        let homeRouter = HomeRouters.start()
        let vc = homeRouter.entry ?? UIViewController()
        self.pushVC(vc)
    }
    
    func onSuccessPostCreate(output: PostCreateOutput) {
        backToHomePage()
    }
    
    func onSuccessPutUpdate(output: PutUpdateOutput) {
        backToHomePage()
    }

    @IBAction func createUpdateButtonAct(_ sender: Any) {
        presenter?.onCreateUpdateValidation(title: titleTF.text ?? "", content: contentTextView.text ?? "", isUpdate: isUpdate, id: id)
    }
    
    @IBAction func cancelButtonAct(_ sender: Any) {
        backToPreviousVC()
    }
}
