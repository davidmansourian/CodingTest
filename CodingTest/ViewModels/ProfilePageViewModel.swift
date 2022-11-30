//
//  ProfilePageViewModel.swift
//  CodingTest
//
//  Created by David on 2022-11-30.
//

import Foundation
import Combine

class ProfilePageViewModel: ObservableObject{
    private var cancellable: Cancellable?
    var coreDataManager = CoreDataManager.shared
    
    init(){
    }
    
    
    func getStoredData() -> [SinglePhoto]{
        let rawLikedData = coreDataManager.fetchLikedData()
        var likedPhotoData: [SinglePhoto] = []
        
        for theImageData in rawLikedData{
            print(theImageData.imageKey)
            likedPhotoData.append(SinglePhoto(id: theImageData.imageKey ?? "", owner: "", secret: "", server: "", farm: 0, title: "", ispublic: 0, isfriend: 0, isfamily: 0, url: theImageData.imageUrl))
        }
        
        return likedPhotoData
    }
}
