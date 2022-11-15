//
//  WordAPI.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/10.
//

class WordAPI: BaseAPI {
    static let shared = WordAPI()
    
    private override init() { }
    
    /// [GET] 단어 리스트 조회
    func getWordList(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(WordService.getWordList).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, WordListResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
