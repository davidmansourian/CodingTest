//
//  ImageResultsViewModel.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import Foundation
import Combine
import SwiftUI
// https://live.staticflickr.com/{server-id}/{id}_{secret}.jpg , need to input search result details into this
class ImageResultsViewModel: ObservableObject{
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    let cacheManager = CacheManager.shared
    
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String){
        urlString = url
        imageKey = key
        getImage()
    }
    
    
    func getImage(){
        if let cachedImage = cacheManager.get(key: urlString){
            image = cachedImage
            print("Getting cached image")
        } else {
            downloadImageResult()
            print("Downloading image")
        }
    }
    
    
    func downloadImageResult(){
        self.isLoading = true
        
        guard let urlString = URL(string: urlString) else {
            self.isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: urlString)
            .map{ UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] theImage in
                guard let self = self,
                      let image = theImage
                else{
                    return
                }
                self.image = image
                self.cacheManager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
    
    func getPickedImageDetails(){
        
    }
    
    
}
