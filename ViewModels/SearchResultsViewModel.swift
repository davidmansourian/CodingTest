//
//  SearchResultsViewModel.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import Foundation
import Combine

class SearchResultsViewModel: ObservableObject{
    var photoSearchService = APILoaderService.shared
    @Published var systemSearchResult: PhotosResults?
    private var cancellable: Cancellable?
    
    init(){
        getSearchResults()
    }
    
    func getSearchResults(){
        cancellable = photoSearchService.$photosModel
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
                self.systemSearchResult = theResults?.photos
            })
    }
    
    
}
