//
//  APILoaderService.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import Foundation
import Combine

class APILoaderService{
    static let shared = APILoaderService()
    @Published var flickrDataModel: [PhotoSearchModel] = []
    private var cancellables = Set<AnyCancellable>()
    private var jsonDecoder = JSONDecoder()
    
    private init(){}
    
    func getData(){
        let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=e8d1203c8e9c9c625b8d4fad4d841140&tags=dogs&sort=+interestingness-desc&format=json&nojsoncallback=1&api_sig=e82e39c05cd1e1fd093cd7d343c66352"
        
        guard let urlString = URL(string: url) else { return }
        
        URLSession.shared.dataTaskPublisher(for: urlString)
            .receive(on: DispatchQueue.main)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [PhotoSearchModel].self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case.finished:
                    print("DEBUG: APIService has successfully fetched and decoded JSON-data")
                    break
                case.failure(let error):
                    print("Error downloading data", error)
                }
            } receiveValue: { [weak self] serverResponse in
                self?.flickrDataModel = serverResponse
            }
            .store(in: &cancellables)
        
    }
}
