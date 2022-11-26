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
    
    var presenter: HomePresenter?
    var dataList: [GetHomeBodyFullResponse] = []
    var currentPage: Int = 1
    var limit: Int = 0
    var totalData: Int = 0
    
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
        
        searchTF.addTarget(self, action: #selector(searchDidChanges), for: .editingChanged)
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
        setupNavBarSquareArrow(title: "Beranda", back: backToRootVC)
    }
    
    func onSuccessHomeData(output: GetHomeOutput) {
        dataList = output.data
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

        cell.titleLabel.text = dataList[indexPath.row].title
        cell.contentTitle.text = dataList[indexPath.row].content
        cell.dateLabel.text = dataList[indexPath.row].updatedAt.formatedDate(from: .ISO, format: .monthInitial)

        return cell
    }
}