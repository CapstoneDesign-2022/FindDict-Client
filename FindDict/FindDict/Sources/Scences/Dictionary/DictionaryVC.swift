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
    private var dictionaryData: [String]?
    private let titleView = UIView().then{
        $0.backgroundColor = .modalButtonDarkYellow
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
    }
    
    private let titleLabel = UILabel().then{
        $0.textColor = .black
        $0.text = "단어장"
        $0.font = .findDictH5R48
    }
    
    private let dictionaryTV = UITableView().then{
        $0.rowHeight = 107
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.backgroundColor = .bgBeige
    }
    
    private let homeButton = UIButton().then{
        $0.setImage(UIImage(named: "homeImage"),for: .normal)
    }
    
    // MARK: - Functions
    private func setTV() {
        dictionaryTV.delegate = self
        dictionaryTV.dataSource = self
        dictionaryTV.separatorStyle = .none
        dictionaryTV.showsVerticalScrollIndicator = true
        dictionaryTV.register(DictionaryTVC.self, forCellReuseIdentifier: "DictionaryTVC")
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
        setButtonActions()
        view.backgroundColor = .bgBeige
    }
    
    private func setButtonActions(){
        homeButton.press{
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
}

extension DictionaryVC {
    private func requestGetWordList() {
        WordAPI.shared.getWordList { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? WordListResponseModel {
                    self.dictionaryData = res.english
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
        view.addSubViews([titleView, dictionaryTV,homeButton])
        titleView.addSubViews([titleLabel])
        
        titleView.snp.makeConstraints{
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.width.equalTo(400)
            $0.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerX.equalTo(titleView)
            $0.centerY.equalTo(titleView)
        }
        
        dictionaryTV.snp.makeConstraints{
            $0.top.equalTo(titleView.snp.bottom).offset(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(206)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(206)
        }
        
        homeButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(60)
            $0.width.height.equalTo(50)
        }
    }
}

// MARK: - UITableViewDataSource
extension DictionaryVC: UITableViewDataSource {
    
    // @required: 특정 위치에 표시할 셀을 요청하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryTVC", for: indexPath) as? DictionaryTVC else {
            return UITableViewCell()
        }
        cell.dictionaryCard.setDelegate(delegate: self)
      
        let data = dictionaryData?[indexPath.row] ?? WordListResponseModel.sampleData[indexPath.row]
        cell.setData(data, cellRowIndex: indexPath.row)
        return cell
    }
    
    // @required: 각 섹션에 표시할 행의 개수를 묻는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionaryData?.count ?? WordListResponseModel.sampleData.count
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
        dictionaryDetailVC.setWordLabelText(english: dictionaryData?[index] ?? WordListResponseModel.sampleData[index])
        dictionaryDetailVC.modalPresentationStyle = .overCurrentContext
        self.present(dictionaryDetailVC, animated: true)
    }
}
