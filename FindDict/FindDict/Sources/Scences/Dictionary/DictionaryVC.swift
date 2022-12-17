//
//  DictionaryVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/30.
//

import UIKit
import SnapKit
import Then

final class DictionaryVC: UIViewController {
    
    // MARK: - Properties
    private var dictionaryData: [String] = []
    
    private let naviView = DefaultNavigationBar(isHomeButtonIncluded: true).then {
        $0.setTitleLabel(title: "Dictionary")
    }
    
    private let dictionaryTV: UITableView = UITableView().then{
        $0.rowHeight = 107
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.backgroundColor = .fdBeige
    }
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        requestGetWordList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTV()
        view.backgroundColor = .fdBeige
        self.navigationController?.navigationBar.isHidden = true
        naviView.setDelegate(delegate: self)
    }
    
    // MARK: - Functions
    private func setTV() {
        dictionaryTV.do{
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = true
            $0.register(DictionaryTVC.self, forCellReuseIdentifier: "DictionaryTVC")
        }
    }
}

// MARK: - Network
extension DictionaryVC {
    private func requestGetWordList() {
        WordAPI.shared.getWordList { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? WordListResponseModel {
                    let removeDuplicateWords: Set = Set(res.english)
                    self.dictionaryData = Array(removeDuplicateWords)
                    self.dictionaryTV.reloadData()
                }
                
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}

// MARK: - UI
extension DictionaryVC {
    private func setLayout() {
        view.addSubViews([naviView, dictionaryTV])
        naviView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        dictionaryTV.snp.makeConstraints{
            $0.top.equalTo(naviView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(206)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(206)
        }
    }
}

// MARK: - UITableViewDataSource
extension DictionaryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryTVC", for: indexPath) as? DictionaryTVC else {
            return UITableViewCell()
        }
        cell.dictionaryCard.setDelegate(delegate: self)
        
        let data = dictionaryData[indexPath.row]
        cell.setData(data, cellRowIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionaryData.count
    }
}

// MARK: - UITableViewDelegate
extension DictionaryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
}

// MARK: - DictionaryCardDelegate
extension DictionaryVC: DictionaryCardDelegate {
    func wordDetailViewButtonClicked(index: Int) {
        let dictionaryDetailVC = DictionaryDetailVC()
        dictionaryDetailVC.setWordLabelText(english: dictionaryData[index])
        dictionaryDetailVC.modalPresentationStyle = .overCurrentContext
        self.present(dictionaryDetailVC, animated: true)
    }
}

// MARK: - DefaultNavigationBarDelegate
extension DictionaryVC: DefaultNavigationBarDelegate {
    func backButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func homeButtonClicked(){
        self.navigationController?.popToRootViewController(animated: false)
    }
}
