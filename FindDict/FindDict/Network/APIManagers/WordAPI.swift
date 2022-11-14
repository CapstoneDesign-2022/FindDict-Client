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
    
    /// [GET] 힌트 이미지 조회
    func getHint(search: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(WordService.getHint(search: search)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, HintResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
}
    /// [POST] 단어 추가
//    func postWord(body: CreateWordBodyModel,
//                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
//        AFmanager.request(WordService.postWord(body: body)).responseData { response in
//            switch response.result {
//            case .success:
//                guard let statusCode = response.response?.statusCode else { return }
//                guard let data = response.data else { return }
//                let networkResult = self.judgeStatus(by: statusCode, data, CreateWordResponseModel.self)
//                completion(networkResult)
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }
}
