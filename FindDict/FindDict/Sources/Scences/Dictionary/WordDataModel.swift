//
//  WordDataModel.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/01.
//

import UIKit

struct WordDataModel {
    let englishWord: String
    let koreanWord: String
}

extension WordDataModel {
    // 더미 데이터
    static let sampleData: [WordDataModel] = [
        WordDataModel(englishWord: "dictionary", koreanWord: "사전"),
        WordDataModel(englishWord: "apple", koreanWord: "사과"),
        WordDataModel(englishWord: "banana", koreanWord: "바나나"),
        WordDataModel(englishWord: "table", koreanWord: "탁자"),
        WordDataModel(englishWord: "pencil", koreanWord: "연필"),
        WordDataModel(englishWord: "bag", koreanWord: "가방"),
        WordDataModel(englishWord: "book", koreanWord: "책"),
        WordDataModel(englishWord: "umbrella", koreanWord: "우산"),
        WordDataModel(englishWord: "chair", koreanWord: "의자"),
        WordDataModel(englishWord: "laptop", koreanWord: "노트북"),
    ]
}
