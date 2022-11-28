//
//  APILoaderService.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import Foundation
import Combine

class APILoaderService: ObservableObject{
    static let shared = APILoaderService()
    @Published var photosModel: PhotoSearchModel?
    @Published var searchString: String = ""
    private var cancellables = Set<AnyCancellable>()
    private var jsonDecoder = JSONDecoder()
    
    private init(){
        $searchString
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global(qos: .default))
            .sink { [weak self] theSearchTerm in
                self?.getData(searchString: theSearchTerm)
            }
            .store(in: &cancellables)

    }
    
    func getData(searchString: String){
        let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=c501bfe94d5c8a4e903109dca4d42551&tags='\(searchString)'&per_page=15&format=json&nojsoncallback=1"
        
        guard let urlString = URL(string: url) else { return }
        
        URLSession.shared.dataTaskPublisher(for: urlString)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .removeDuplicates()
            .decode(type: PhotoSearchModel.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case.finished:
                    print("DEBUG: APIService has successfully fetched and decoded JSON-data")
                    break
                case.failure(let error):
                    print("Error downloading data", error)
                }
            } receiveValue: { [weak self] modelResponse in
                self?.photosModel = modelResponse
            }
            .store(in: &cancellables)
        
    }
}
