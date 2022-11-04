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
        GameTutorialCVCModel(tutorialTitle: "숨은 그림 찾기 게임하기", tutorialImageTitle: "tutorialExampleImage", tutorialText: "그림 속에서 단어들을 찾아서 클릭해보세요!"),
        GameTutorialCVCModel(tutorialTitle: "찾은 물체 발음 듣기", tutorialImageTitle: "tutorialExampleImage", tutorialText: "물체를 찾았을 때 물체의 영어 단어를 미국식/영국식/호주식 발음으로 들을 수 있어요"),
        GameTutorialCVCModel(tutorialTitle: "힌트", tutorialImageTitle: "tutorialExampleImage", tutorialText: "모르는 단어일 때 단어를 클릭해보세요! 힌트를 볼 수 있어요"),
        GameTutorialCVCModel(tutorialTitle: "Game Over...", tutorialImageTitle: "tutorialExampleImage", tutorialText: "3번 이상 틀리면 게임이 종료됩니다. 다시 게임을 할 수도 있고, 단어장에 가서 게임한 단어들을 다시 볼 수 있어요"),
        GameTutorialCVCModel(tutorialTitle: "단어장", tutorialImageTitle: "tutorialExampleImage", tutorialText: "'사진 확인하기' 버튼을 클릭하면 게임한 사진을 다시 확인해볼 수 있어요"),
    ]
}
