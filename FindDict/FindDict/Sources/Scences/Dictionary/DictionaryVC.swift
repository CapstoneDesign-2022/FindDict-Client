//
//  DictionaryVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/30.
//

import UIKit
import SnapKit
import Then

class DictionaryVC: UIViewController {
    
    // MARK: - Properties
    private let titleView = UIView().then{
        $0.backgroundColor = .white
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
//        dictionaryTV.
        dictionaryTV.dataSource = self
        dictionaryTV.showsVerticalScrollIndicator = false
        dictionaryTV.register(DictionaryTVC.self, forCellReuseIdentifier: "DictionaryTVC")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTV()
        setButtonActions()
        view.backgroundColor = .bgBeige
    }
    
    func setButtonActions(){
        homeButton.press{
            self.navigationController?.popToRootViewController(animated: false)
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(52)
            $0.width.equalTo(601)
            $0.height.equalTo(119)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerX.equalTo(titleView)
            $0.centerY.equalTo(titleView)
        }
        
        dictionaryTV.snp.makeConstraints{
            $0.top.equalTo(titleView.snp.bottom).offset(97)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(206)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-206)
        }
        
        homeButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
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
        
        cell.setData(WordDataModel.sampleData[indexPath.row], index: indexPath.row)
        cell.dictionaryCard.delegate = self
        return cell
    }
    
    // @required: 각 섹션에 표시할 행의 개수를 묻는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WordDataModel.sampleData.count
    }
}

// MARK: - UITableViewDelegate
extension DictionaryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
}

extension DictionaryVC: DictionaryCardDelegate {
    func wordDetailViewButtonClicked(index: Int) {
        print(">>>>>>>>",WordDataModel.sampleData[index].englishWord)
        let dictionaryDetailVC = DictionaryDetailVC()
        dictionaryDetailVC.setWordLabelText(english: WordDataModel.sampleData[index].englishWord)
        self.navigationController?.pushViewController(dictionaryDetailVC, animated: true)
    }
}
