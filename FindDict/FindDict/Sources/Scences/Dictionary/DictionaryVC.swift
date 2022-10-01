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
    
    // MARK: - Functions
    private func setTV() {
        dictionaryTV.delegate = self
        dictionaryTV.dataSource = self
        dictionaryTV.showsVerticalScrollIndicator = false
        dictionaryTV.register(DictionaryTVC.self, forCellReuseIdentifier: "DictionaryTVC")
        // forCellReuseIdentifier: TV애서 여러 개의 TVC를 사용할 수 있기 때문에 identifier로 구분한다.
        // 나중에 UITableViewDataSource에서 identifier로 필요한 셀을 사용한다.
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTV()
        view.backgroundColor = .bgBeige
    }
    
}

// MARK: - UI
extension DictionaryVC {
    private func setLayout() {
        view.addSubViews([titleView, dictionaryTV])
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
    }
    
}

// MARK: - UITableViewDataSource
extension DictionaryVC: UITableViewDataSource {
    // @required: 특정 위치에 표시할 셀을 요청하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeueReusableCell의 반환값이 optional(UITableViewCell?)이기 때문에 guard else{}문을 사용
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryTVC", for: indexPath) as? DictionaryTVC else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    // @required: 각 섹션에 표시할 행의 개수를 묻는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.tableArray.count
        return 10
    }
    
    // 표현할 데이터 리스트의 count를 return 해주고 cell을 dequeueReusableCell 한 다음
    // textLabel에 값을 넣고 return해주면 끝 ??
    // widthIdentifier는 아까 사용할 TV셀을 등록할 때 정했던 String을 넣어야 함
}

// MARK: - UITableViewDelegate
extension DictionaryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
}
