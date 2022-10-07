//
//  GameTutorialCVCModel.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/06.
//

import UIKit

struct GameTutorialCVCModel {
    let tutorialCellName: String
    var tutorialImage: UIImage? {
        return UIImage(named: tutorialCellName)
    }
    let tutorialText: String
}

// MARK: - Extensions
extension GameTutorialCVCModel {
    static var sampleData: [GameTutorialCVCModel] = [
        GameTutorialCVCModel(tutorialCellName: "숨은 그림 찾기", tutorialText: "맞으면 좋아요~ 동그라미가 나오고~ 좋아요 아무튼~ 단어 리스트에 있는 단어들을 사진에서 찾아서 클릭해보세요~!! "),
        GameTutorialCVCModel(tutorialCellName: "잘못 찾았다면?", tutorialText: "틀리면 안 좋아요. 수명 깎임요"),
        GameTutorialCVCModel(tutorialCellName: "힌트 보는 법", tutorialText: "모르겠으면 한글 단어를 클릭해 보세요. 힌트가 나온답니다,,,"),
        GameTutorialCVCModel(tutorialCellName: "Game Over...", tutorialText: "단어 리스트에 있는 단어를 모두 다 찾거나 3번 이상 틀리면 게임이 끝나요."),
        GameTutorialCVCModel(tutorialCellName: "단어장", tutorialText: "단어장에 가면 이때까지 게임했던 단어들을 모아 볼 수 있어요"),
        GameTutorialCVCModel(tutorialCellName: "단어장 사진 보기", tutorialText: "사진 보기 버튼을 클릭하면 게임했던 사진도 볼 수 있답니다~~~~~"),
    ]
}
