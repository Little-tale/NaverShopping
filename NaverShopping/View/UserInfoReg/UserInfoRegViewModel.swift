//
//  UserInfoRegViewModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import UIKit.UIImage
import Combine

// MARK: ViewModel
final class UserInfoRegViewModel: MVIPatternType {
    
    private
    var cancellable = Set<AnyCancellable> ()
    
    @Published
    var imagePickerState: ImagePickState = .empty
    
    @Published
    var stateModel = StateModel()
    
    enum Intent { // 다시 학습해 보자. 사용자의 의도를 관리
        case selectImages([UIImage])
        case nameText(String)
        case introduce(String)
        case phoneNumber(String)
    }
    
    struct StateModel { // 상태를 담당
        var nameText = ""
        var introduce = ""
        var phoneNumber = ""
        var userImageUrl: String? = nil
    }
}

// MARK: Intent Handle
extension UserInfoRegViewModel {
    
    func handle(intent: Intent) {
        switch intent {
        case .selectImages(let images):
            processingImage(images)
            
        case .nameText(let name):
            stateModel.nameText = name
            
        case .introduce(let introduce):
            stateModel.introduce = introduce
            
        case .phoneNumber(let phoneNumber):
            stateModel.phoneNumber = phoneNumber
        }
    }
}

// MARK: Processing
extension UserInfoRegViewModel {
    private
    func processingImage(_ images: [UIImage]) {
        if let firstImage = images.first {
            imagePickerState = .success(firstImage)
        } else {
            imagePickerState = .empty
        }
    }
}
