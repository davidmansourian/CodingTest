//
//  ProfilePageViewModel.swift
//  CodingTest
//
//  Created by David on 2022-11-30.
//

import Foundation
import Combine

class ProfilePageViewModel: ObservableObject{
    private var cancellables = Set<AnyCancellable>()
    var coreDataManager = CoreDataManager.shared
    @Published var likedPhotos: [SinglePhoto] = []
    
    init(){
        updateLikedPhotosView()
    }
    
    
    func updateLikedPhotosView(){
        coreDataManager.$likedPhotoData
            .sink { [weak self] theResults in
                guard let self = self else { return }
                self.likedPhotos.removeAll()
                for theImageData in theResults{
                    self.likedPhotos.append(SinglePhoto(id: theImageData.imageKey ?? "", secret: "", server: "", farm: 0, title: "", url: theImageData.imageUrl))
                }
            }.store(in: &cancellables)
        
    }
}


extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
