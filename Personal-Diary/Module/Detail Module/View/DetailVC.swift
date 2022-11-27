//
//  DetailVC.swift
//  Personal-Diary
//
//  Created by Isaac on 11/27/22.
//

import UIKit

class DetailVC: BaseVC, DetailView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var presenter: DetailPresenter?
    var currentId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
        setupNavBarSquareArrow(title: "Detail", back: backToPreviousVC)
    }
    
    func onSuccessGetDetail(output: GetDetailOutput) {
        titleLabel.text = output.title
        dateLabel.text = "Update at \(output.updatedAt.formatedDate(from: .ISO, format: .monthInitial))"
        contentLabel.text = output.content
        currentId = output.id
    }

    @IBAction func updateBtnAction(_ sender: Any) {
        let createUpdateRouter = CreateUpdateRouters.start(isUpdate: true, title: titleLabel.text ?? "", content: contentLabel.text ?? "", id: currentId)
        let vc = createUpdateRouter.entry ?? UIViewController()
        self.pushVC(vc)
    }
}
