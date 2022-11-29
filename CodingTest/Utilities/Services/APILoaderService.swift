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
    
    let apiUrl = "https://api.flickr.com/services/rest/"
    let chosenMethod = "flickr.photos.search"
    let appKey = "3ace85391fe1920dc335451547af721e"
    let chosenSort = "relevance"
    let safeSearch = "1"
    let format = "json"
    let noJsonCallback = "1"
    
    var perPage: String = ""
    var page: String = ""
    
    
    private init(){
        $searchString
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global(qos: .default))
            .sink { [weak self] theSearchTerm in
                if theSearchTerm == ""{
                    self?.buildUrl(searchString: "mountain")
                } else {
                    self?.buildUrl(searchString: theSearchTerm)
                }
            }
            .store(in: &cancellables)

    }
    
    
    // https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=e0e0491ecf307142438276bcaea824b9&text=%22%22&sort=relevance&safe_search=1&per_page=100&page=1&format=json&nojsoncallback=1
    
    // Spaces didn't work in search results. Investigated the issue and found URLcomponents. Seems like a better way to build url strings for APIs. Don't know if it is the best idea to use the searchString in the buildURL, will revise later if so.
    
    // info taken from https://developer.apple.com/forums/thread/679238
    
    
    func buildUrl(searchString: String){
        var components = URLComponents(string: apiUrl)
        
        components?.queryItems = [URLQueryItem(name: "method", value: chosenMethod),
                                  URLQueryItem(name: "api_key", value: appKey),
                                  URLQueryItem(name: "text", value: searchString),
                                  URLQueryItem(name: "sort", value: chosenSort),
                                  URLQueryItem(name: "safe_search", value: safeSearch),
                                  URLQueryItem(name: "per_page", value: "48"),
                                  URLQueryItem(name: "format", value: format),
                                  URLQueryItem(name: "nojsoncallback", value: noJsonCallback)]
        
        getData(url: components?.url ?? URL(fileURLWithPath: ""))
        print(components?.url ?? "")
    }
    
    func getData(url: URL){
        let theUrl = url.absoluteString
        
        guard let urlString = URL(string: theUrl) else { return }
        
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
                    print("DEBUG: Error downloading data", error)
                }
            } receiveValue: { [weak self] modelResponse in
                self?.photosModel = modelResponse
            }
            .store(in: &cancellables)
        
    }
}
