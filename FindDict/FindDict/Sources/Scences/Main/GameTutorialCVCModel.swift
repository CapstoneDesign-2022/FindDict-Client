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
        GameTutorialCVCModel(tutorialTitle: "숨은 그림 찾기", tutorialImageTitle: "tutorialExampleImage", tutorialText: "맞으면 좋아요~ 동그라미가 나오고 단어 리스트에 있는 단어들을 사진에서 찾아서 클릭해보세요~!! "),
        GameTutorialCVCModel(tutorialTitle: "잘못 찾았다면?", tutorialImageTitle: "tutorialExampleImage", tutorialText: "틀리면 안 좋아요."),
        GameTutorialCVCModel(tutorialTitle: "힌트 보는 법", tutorialImageTitle: "tutorialExampleImage", tutorialText: "모르겠으면 한글 단어를 클릭해 보세요. 힌트가 나온답니다,,,"),
        GameTutorialCVCModel(tutorialTitle: "Game Over...", tutorialImageTitle: "tutorialExampleImage", tutorialText: "단어 리스트에 있는 단어를 모두 다 찾거나 3번 이상 틀리면 게임이 끝나요!!!"),
        GameTutorialCVCModel(tutorialTitle: "단어장", tutorialImageTitle: "tutorialExampleImage", tutorialText: "단어장에 가면 이때까지 게임했던 단어들을 모아 볼 수 있어요"),
        GameTutorialCVCModel(tutorialTitle: "단어장 사진 보기", tutorialImageTitle: "tutorialExampleImage", tutorialText: "사진 보기 버튼을 클릭하면 게임했던 사진도 볼 수 있답니다~~~~~"),
    ]
}
