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
    
    let urlString: String
    
    init(url: String){
        urlString = url
        getImageResults()
    }
    
    
    
    func getImageResults(){
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
                self?.image = theImage
            }
            .store(in: &cancellables)
    }
    
    
}
