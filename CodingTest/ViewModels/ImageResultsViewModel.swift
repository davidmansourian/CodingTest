//
//  ImageResultsViewModel.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import Foundation
import Combine
import SwiftUI

class ImageResultsViewModel: ObservableObject{
    @Published var image: UIImage? = nil
    @Published var imageDescription: String = ""
    @Published var imageUploader: String = ""
    @Published var imageDate: String = ""
    @Published var fullImageString: String = ""
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    let cacheManager = CacheManager.shared
    
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String){
        urlString = url
        imageKey = key
        getImage()
        getImageDescription()
    }
    
    
    func getImage(){
        if let cachedImage = cacheManager.get(key: urlString){
            image = cachedImage
            print("DEBUG: Getting cached image")
        } else {
            downloadImageResult()
            print("DEBUG: Downloading image")
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
    
    func getImageDescription(){
        print("imageId:", self.imageKey)
        let urlString = "https://www.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=3ace85391fe1920dc335451547af721e&photo_id=\(imageKey)&format=json&nojsoncallback=1"
        
        print("urlstring:", urlString)
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: PhotoResultModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case.finished:
                    print("DEBUG: \(completion) grabbing image description.")
                    break
                case.failure(let error):
                    print("DEBUG: Error grabbing image description \(error)")
                }
            } receiveValue: { [weak self] photoData in
                guard let self = self else { return }
                self.imageDescription = photoData.photo.photoDescription.content
                self.imageUploader = photoData.photo.owner.username
                self.imageDate = self.dateFormatter(unixStamp: photoData.photo.dateuploaded)
                self.fullImageString = "\(self.imageDescription) by \(self.imageUploader) at \(self.imageDate)"
                
            }.store(in: &cancellables)

    }
    
    private func dateFormatter(unixStamp: String) -> String{
        let formatter = DateFormatter()
        let theDate =  NSDate(timeIntervalSince1970: Double(unixStamp) ?? 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: theDate as Date)
    }
    
}


