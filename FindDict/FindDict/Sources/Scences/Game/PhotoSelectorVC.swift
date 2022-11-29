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
    private let objectDetectionVC: ObjectDetectionVC = ObjectDetectionVC()
    
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
            
            objectDetectionVC.setGameVC(gameVC: gameVC)
            objectDetectionVC.setPixelBuffer(pixelBuffer: selectedImage.image?.pixelBufferFromImage())
            objectDetectionVC.setNavigationController(navigationController: self.navigationController)
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setButtonActions()
        view.backgroundColor = .bgBeige
        objectDetectionVC.setDelegate(delegate: self)
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
        
        homeButton.press{
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
}

// MARK: - UI
extension PhotoSelectorVC {
    private func setLayout() {
        view.addSubViews([takingPictureButton, selectingPictureButton,fetchingPictureButton, homeButton])
        
        takingPictureButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
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
        
        homeButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(60)
            $0.width.height.equalTo(50)
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

// MARK: -PhotoSelectorVCDelegate
extension PhotoSelectorVC: ObjectDetectionVCDelegate {
    func lackOfObject() {
        self.dismiss(animated: true)
        let photoReselectVC = PhotoReSelectVC()
        photoReselectVC.modalPresentationStyle = .overCurrentContext
        self.present(photoReselectVC, animated: true)
    }
}
