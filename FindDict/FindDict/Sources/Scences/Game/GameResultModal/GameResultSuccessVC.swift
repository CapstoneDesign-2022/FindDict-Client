//
//  GameResultSuccessVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/06.
//

import UIKit
import Then
import SnapKit

class GameResultSuccessVC: ModalBaseVC {
    
    // MARK: - UI
    func setUI(){
        resultImage.image = UIImage(named: "successImage")
        resultTitleLabel.text = "Game Clear"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
//        mainViewButton.press{
//            //            guard let navigation = self.presentingViewController?.navigationController else { return }
//            //            self.dismiss(animated: true, completion: {
//            //                navigation.popToRootViewController(animated: true)
//            //            })
//            
//            guard let pvc = self.presentingViewController else { return }
////            self.dismiss(animated: true) {
////                pvc.navigationController?.pushViewController(MainVC(), animated: true)
////            }
//            pvc.dismiss(animated: true) {
//                pvc.navigationController?.popToRootViewController(animated: true)
////                pvc.navigationController?.pushViewController(MainVC(), animated: true)
//            }
//        }
//        setButtonActions()
    }
    
//    func setButtonActions(){
//        retryButton.press{
//            guard let pvc = self.presentingViewController else { return }
//            self.dismiss(animated: true, completion: {
//                pvc.navigationController?.pushViewController(PhotoSelectorVC(), animated: true)
//            })
////            self.view.window?.rootViewController?.dismiss(animated: false, completion: {
////              let initiatingGameVC = PhotoSelectorVC()
////                guard let presentingVC = self.presentingViewController as? UINavigationController else { return }
////                self.view.window?.rootViewController?.dismiss(animated: false){
////                           presentingVC.popToRootViewController(animated: true)}
////            })
//        }
//
//        dictionaryButton.press{
//            guard let pvc = self.presentingViewController else { return }
////            let dictionaryVC = DictionaryVC()
//            self.dismiss(animated: true, completion: {
//                pvc.navigationController?.pushViewController(DictionaryVC(), animated: true)
//            })
////            self.navigationController?.pushViewController(dictionaryVC, animated: true)
//        }
//
//        mainViewButton.press{
//            guard let pvc = self.presentingViewController else { return }
//            self.dismiss(animated: true, completion: {
//                pvc.navigationController?.pushViewController(MainVC(), animated: true)
//            })
//        }
//    }
}
