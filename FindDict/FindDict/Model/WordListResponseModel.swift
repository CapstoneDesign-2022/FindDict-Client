//
//  WordListResponseModel.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/10.
//

import Foundation

struct WordListResponseModel: Codable {
    let words: [Word] = []

    enum CodingKeys: String, CodingKey {
        case words = "words"
    }
    
    struct Word: Codable {
        let korean: String
        let english: String

        enum CodingKeys: String, CodingKey {
            case korean = "korean"
            case english = "english"
        }
    }
}


extension WordListResponseModel {
    static let sampleData: [Word] = [
        Word(korean: "사전", english: "dictionary"),
        Word(korean: "사과", english: "apple"),
        Word(korean: "바나나", english: "banana"),
        Word(korean: "탁자", english: "table"),
        Word(korean: "연필", english: "pencil"),
        Word(korean: "가방", english: "bag"),
        Word(korean: "책", english: "book"),
        Word(korean: "우산", english: "umbrella"),
        Word(korean: "의자", english: "chair"),
        Word(korean: "노트북", english: "laptop"),
    ]
}

