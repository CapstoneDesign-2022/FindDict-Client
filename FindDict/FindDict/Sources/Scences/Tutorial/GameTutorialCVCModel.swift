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
        GameTutorialCVCModel(tutorialTitle: "숨은 물체 찾기 게임하기", tutorialImageTitle: "Game", tutorialText: "찾아야 할 물체들이 영어 단어 목록으로 주어져요.사진에서 물체들을 찾아 순서대로  클릭해보세요!\n\n정답을 맞히면 동그라미, 틀리면 🥲가 표시됩니다"),
        GameTutorialCVCModel(tutorialTitle: "숨은 물체를 찾았을 때", tutorialImageTitle: "FoundAnswer", tutorialText: "사진 속에서 물체를 올바르게 찾아 클릭하면\n영어 단어를 미국 / 영국 / 호주식 발음으로 들을 수 있어요!"),
        GameTutorialCVCModel(tutorialTitle: "힌트", tutorialImageTitle: "Hint", tutorialText: "모르는 단어가 나왔을 때는 단어를 클릭해보세요!\n\n사진 힌트를 볼 수 있어요"),
        GameTutorialCVCModel(tutorialTitle: "Game Success", tutorialImageTitle: "GameSuccess", tutorialText: "모든 단어를 찾으면 게임이 종료됩니다!\n\n다시 사진을 골라 새 게임을 시작하거나\n단어장으로 이동해 게임에서 배운 영어 단어들을 다시 확인할 수도 있어요"),
        GameTutorialCVCModel(tutorialTitle: "단어장", tutorialImageTitle: "Dictionary", tutorialText: "게임을 통해 배운 모든 영어 단어들을 단어장 페이지에서 모아볼 수 있어요"),
        GameTutorialCVCModel(tutorialTitle: "단어별 사진 보기", tutorialImageTitle: "DictionaryDetail", tutorialText: "사진 슬라이드를 넘겨보세요!\n물체 단어가 등장했던 게임 사진들을 모아볼 수 있어요\n\n발음도 함께 들으며 단어를 익혀보세요"),
    ]
}
