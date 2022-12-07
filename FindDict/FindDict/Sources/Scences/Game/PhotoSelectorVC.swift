//
//  PhotoSelectorVCViewController.swift
//  FindDict
//
//  Created by 김지민 on 2022/09/27.
//

import UIKit
import SnapKit
import Then

final class PhotoSelectorVC: UIViewController {
    
    // MARK: - Properties
    private let gameVC: GameVC = GameVC()
    private let objectDetector: ObjectDetector = ObjectDetector()
    
    private let naviView = DefaultNavigationBar(isHomeButtonIncluded: true).then {
        $0.setTitleLabel(title: "Game")
    }
    
    private let takingPictureButton: PhotoSelectorButton = PhotoSelectorButton().then{
        $0.setTitle("사진 찍기", for: .normal)
        $0.backgroundColor = .buttonOrange
    }
    
    private let selectingPictureButton: PhotoSelectorButton = PhotoSelectorButton().then{
        $0.setTitle("앨범에서 사진 선택", for: .normal)
        $0.backgroundColor = .buttonApricot
    }
    
    private let fetchingPictureButton: PhotoSelectorButton = PhotoSelectorButton().then{
        $0.setTitle("기본 이미지", for: .normal)
        $0.backgroundColor = .buttonYellow
    }
    
    private let homeButton: UIButton = UIButton().then{
        $0.setImage(UIImage(named: "homeImage"),for: .normal)
    }
    
    private var selectedImage: UIImageView = UIImageView()
    
    private var pixelBuffer: CVPixelBuffer? = nil  {
        didSet{
            gameVC.image.image = selectedImage.image
            
            objectDetector.setNavigationController(navigationController: self.navigationController)
            objectDetector.setGameVC(gameVC: gameVC)
            objectDetector.setPixelBuffer(pixelBuffer: selectedImage.image?.pixelBufferFromImage())
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setButtonActions()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .bgBeige
        objectDetector.setDelegate(delegate: self)
        naviView.setDelegate(delegate: self)
    }
    
    // MARK: - Functions
    private func setButtonActions(){
        takingPictureButton.press{
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
        
        selectingPictureButton.press{
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
}

// MARK: - UI
extension PhotoSelectorVC {
    private func setLayout() {
        view.addSubViews([naviView, takingPictureButton, selectingPictureButton,fetchingPictureButton])
        
        naviView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        takingPictureButton.snp.makeConstraints{
            $0.top.equalTo(naviView.snp.bottom).offset(50)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(60)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-60)
            $0.height.equalTo(100)
        }
        
        selectingPictureButton.snp.makeConstraints{
            $0.top.equalTo(takingPictureButton.snp.bottom).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(60)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-60)
            $0.height.equalTo(100)
        }
        
        fetchingPictureButton.snp.makeConstraints{
            $0.top.equalTo(selectingPictureButton.snp.bottom).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(60)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-60)
            $0.height.equalTo(100)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension PhotoSelectorVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage
        {
            selectedImage.image = image
            pixelBuffer = selectedImage.image?.pixelBufferFromImage()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - ObjectDetectorDelegate
extension PhotoSelectorVC: ObjectDetectorDelegate {
    func lackOfObject() {
        self.dismiss(animated: true)
        let photoReselectModalVC = PhotoReselectModalVC()
        photoReselectModalVC.modalPresentationStyle = .overCurrentContext
        self.present(photoReselectModalVC, animated: true)
    }
}

// MARK: - DefaultNavigationBarDelegate
extension PhotoSelectorVC: DefaultNavigationBarDelegate {
    func backButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func homeButtonClicked(){
        self.navigationController?.popToRootViewController(animated: false)
    }
}
