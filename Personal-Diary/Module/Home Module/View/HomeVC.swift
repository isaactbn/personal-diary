//
//  HomeVC.swift
//  Personal-Diary
//
//  Created by Isaac on 11/21/22.
//

import UIKit

class HomeVC: BaseVC, HomeView {
    
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var createDiaryView: UIView!
    
    @IBOutlet weak var unarchivedView: UIView!
    @IBOutlet weak var archivedView: UIView!
    @IBOutlet weak var unarchivedLabel: UILabel!
    @IBOutlet weak var archivedLabel: UILabel!
    
    
    var presenter: HomePresenter?
    var dataList: [GetHomeBodyFullResponse] = []
    private var viewWrapper: [UIView] = []
    var currentPage: Int = 1
    var limit: Int = 0
    var totalData: Int = 0
    private var isArchived: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTable()
    }
    
    private func setupView() {
        searchView.setupRadius(type: .custom(12))
        searchView.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1), alpha: 0.06, x: -1, y: 1, blur: 6, spread: 0)
        
        createDiaryView.setupRadius(type: .custom(34))
        createDiaryView.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1), alpha: 0.06, x: -1, y: 1, blur: 6, spread: 0)
        
        viewWrapper = [unarchivedView, archivedView]
        for (_, value) in viewWrapper.enumerated() {
            value.setupRadius(type: .custom(12.0), isMaskToBounds: true)
            value.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1), alpha: 0.06, x: -1, y: 1, blur: 6, spread: 0)
        }
        
        unarchivedView.tapGesture(action: {
            self.setButtonView(isArchived: false)
        })
        
        archivedView.tapGesture(action: {
            self.setButtonView(isArchived: true)
        })
        
        searchTF.addTarget(self, action: #selector(searchDidChanges), for: .editingChanged)
        
        createDiaryView.tapGesture(action: { [self] in
            let createUpdateRouter = CreateUpdateRouters.start(isUpdate: false, title: "", content: "", id: "")
            let vc = createUpdateRouter.entry ?? UIViewController()
            self.pushVC(vc)
        })
    }
    
    private func setButtonView(isArchived: Bool) {
        if isArchived {
            unarchivedView.backgroundColor = .white
            unarchivedLabel.textColor = .blackBody
            
            archivedView.backgroundColor = .blueTitle
            archivedLabel.textColor = .white
            
            self.isArchived = true
            
            presenter?.onGetDiaryList(search: "")
        } else {
            unarchivedView.backgroundColor = .blueTitle
            unarchivedLabel.textColor = .white
            
            archivedView.backgroundColor = .white
            archivedLabel.textColor = .blackBody
            
            self.isArchived = false
            
            presenter?.onGetDiaryList(search: "")
        }
    }
    
    @objc private func searchDidChanges(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.presenter?.onGetDiaryList(search: self.searchTF.text ?? "")
        }
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DiaryListCell", bundle: nil), forCellReuseIdentifier: "DiaryListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
        setupNavBarSquareArrowWithLogoutBtn(title: "Beranda")
    }
    
    func onSuccessHomeData(output: GetHomeOutput) {
        dataList = output.data.filter({$0.isArchieved == isArchived})
        currentPage = output.page
        limit = output.limit
        totalData = output.totalData
        
        tableView.reloadData()
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.heightTable.constant = self.tableView.contentSize.height
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryListCell", for: indexPath) as? DiaryListCell else {
            return UITableViewCell()
        }
        
        cell.archivedImageView.isHidden = !dataList[indexPath.row].isArchieved
        cell.titleLabel.text = dataList[indexPath.row].title
        cell.contentTitle.text = dataList[indexPath.row].content
        cell.dateLabel.text = dataList[indexPath.row].updatedAt.formatedDate(from: .ISO, format: .monthInitial)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailRouter = DetailRouters.start(id: dataList[indexPath.row].id)
        let vc = detailRouter.entry ?? UIViewController()
        self.pushVC(vc)
    }
}
