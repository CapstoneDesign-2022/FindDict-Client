//
//  GameTutorialCVCModel.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/06.
//

import UIKit

struct GameTutorialCVCModel {
    let tutorialTitle: String
    let tutorialImageTitle: String
    var tutorialImage: UIImage? {
        return UIImage(named: tutorialImageTitle)
    }
    let tutorialText: String
}

// MARK: - Extensions
extension GameTutorialCVCModel {
    static var sampleData: [GameTutorialCVCModel] = [
        // TODO: 사진 멀쩡한 걸로 수정하기
        GameTutorialCVCModel(tutorialTitle: "숨은 그림 찾기 게임하기", tutorialImageTitle: "Game", tutorialText: "그림 속에 있는 물체들을 순서대로 찾아 클릭해보세요!\n\n 맞으면 동그라미, 틀리면 표시돼요\n 단어를 찾으면 그 다음 단어로 넘어갑니다"),
        GameTutorialCVCModel(tutorialTitle: "숨은 물체를 찾았을 때", tutorialImageTitle: "FoundAnswer", tutorialText: "정답을 클릭했을 때 물체의 영어 단어를 미국식/영국식/호주식 발음으로 들을 수 있어요"),
        GameTutorialCVCModel(tutorialTitle: "힌트", tutorialImageTitle: "Hint", tutorialText: "모르는 단어가 나왔을 때는 단어를 클릭해보세요!\n힌트를 볼 수 있어요\n\nX를 누르면 다시 게임으로 돌아갑니다"),
        GameTutorialCVCModel(tutorialTitle: "Game Success", tutorialImageTitle: "GameSuccess", tutorialText: "모든 단어를 찾으면 게임이 종료됩니다\n\n다시 게임을 할 수도 있고, 단어장에 가서 게임한 단어들을 모아 볼 수 있어요"),
        GameTutorialCVCModel(tutorialTitle: "단어장", tutorialImageTitle: "Dictionary", tutorialText: "게임에 등장했던 단어들은 단어장 페이지에서 모아볼 수 있어요"),
        GameTutorialCVCModel(tutorialTitle: "단어 사진 보기", tutorialImageTitle: "DictionaryDetail", tutorialText: "게임에 등장했던 물체의 사진들을 슬라이드로 넘겨보세요!\n\n발음도 다시 들을 수 있어요"),
    ]
}
