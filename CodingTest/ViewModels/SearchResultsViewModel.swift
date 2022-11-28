//
//  SearchResultsViewModel.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import Foundation
import Combine
import SwiftUI

// https://live.staticflickr.com/{server-id}/{id}_{secret}.jpg , need to input search result details into this

class SearchResultsViewModel: ObservableObject{
    var photoSearchService = APILoaderService.shared
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var photosResults: [SinglePhoto] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getSearchResults()

    }
    
    func getSearchResults(){
        photoSearchService.$photosModel
            .sink(receiveCompletion: { completion in
                switch completion{
                case.finished:
                    print("Finished grapping photos array from service")
                    break
                case.failure(let error):
                    print("error")
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] theResults in
                guard let self = self else { return }
                self.photosResults = theResults?.photos.photo ?? []
                self.loadResultsWithURL()
                
            })
            .store(in: &cancellables)
    }
    
    func loadResultsWithURL(){
        for i in 0..<photosResults.count{
            let serverId = photosResults[i].server
            let imageId = photosResults[i].id
            let secret = photosResults[i].secret
        
            print("https://live.staticflickr.com/\(serverId)/\(imageId)_\(secret).jpg")
            
            photosResults[i].url = "https://live.staticflickr.com/\(serverId)/\(imageId)_\(secret).jpg"
        }
    }
}
