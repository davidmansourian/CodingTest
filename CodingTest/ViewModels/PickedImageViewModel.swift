//
//  PickedImageViewModel.swift
//  CodingTest
//
//  Created by David on 2022-11-29.
//

import Foundation
import Combine


class PickedImageViewModel: ObservableObject{
    @Published var likedUrlString: String = ""
    @Published var likedKeyString: String = ""
    @Published var likeButtonTapped: Bool = false
    var coreDataManager = CoreDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    var isLiked: Bool = false
    
    init(){
        checkIfLiked()
        $likeButtonTapped
            .sink { [weak self] isTapped in
                guard let self = self else { return }
                if isTapped{
                    self.handleImage()
                }
            }.store(in: &cancellables)
    }
    
    func checkIfLiked(){
        Publishers.Zip($likedUrlString, $likedKeyString)
            .sink { [weak self] publishedUrl, publishedKey in
                guard let self = self else { return }
                self.isLiked = self.coreDataManager.photoIsLiked(urlString: publishedUrl, keyString: publishedKey)
                
            }.store(in: &cancellables)
    }
    
    
    func handleImage(){
         Publishers.Zip($likedUrlString, $likedKeyString)
            .sink(receiveCompletion: { completion in
                switch completion{
                case.finished:
                    print(completion)
                    break
                case.failure(let error):
                    print("Couldn't register liked image.", error)
                }
            }, receiveValue: { [weak self] likedImageUrl, likedImageString in
                self?.coreDataManager.likeUnlikeImage(urlString: likedImageUrl, keyString: likedImageString)
            })
            .store(in: &cancellables)
    }
}
