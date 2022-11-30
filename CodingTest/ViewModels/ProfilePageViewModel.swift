//
//  ProfilePageViewModel.swift
//  CodingTest
//
//  Created by David on 2022-11-30.
//

import Foundation

class ProfilePageViewModel: ObservableObject{
    var coreDataManager = CoreDataManager.shared
    
    func getStoredData(){
        coreDataManager.fetchLikedData()
    }
}
