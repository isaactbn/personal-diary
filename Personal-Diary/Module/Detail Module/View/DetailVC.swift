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
    @IBOutlet weak var archivedButtonView: UIButton!
    
    var presenter: DetailPresenter?
    var currentId: String = ""
    private var isArchived: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
        setupNavBarSquareArrow(title: "Detail", back: backToPreviousVC)
    }
    
    private func setupView() {
        archivedButtonView.backgroundColor = UIColor.fromGradientWithDirection(.leftToRight, frame: archivedButtonView.frame, colors: [#colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1),#colorLiteral(red: 0.3058823529, green: 0.4235294118, blue: 0.8431372549, alpha: 1)])
    }
    
    func onSuccessGetDetail(output: GetDetailOutput) {
        titleLabel.text = output.title
        dateLabel.text = "Update at \(output.updatedAt.formatedDate(from: .ISO, format: .monthInitial))"
        contentLabel.text = output.content
        currentId = output.id
        isArchived = output.isArchieved
        
        if isArchived {
            archivedButtonView.setTitle("Unarchived", for: .normal)
        } else {
            archivedButtonView.setTitle("Archive", for: .normal)
        }
    }

    @IBAction func updateBtnAction(_ sender: Any) {
        let createUpdateRouter = CreateUpdateRouters.start(isUpdate: true, title: titleLabel.text ?? "", content: contentLabel.text ?? "", id: currentId)
        let vc = createUpdateRouter.entry ?? UIViewController()
        self.pushVC(vc)
    }
    
    @IBAction func archivedButtonAction(_ sender: Any) {
        if isArchived {
            presenter?.onPutUnarchiveDiary(id: currentId)
        } else {
            presenter?.onPutArchiveDiary(id: currentId)
        }
    }
}
