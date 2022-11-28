//
//  FlickrDataModel.swift
//  CodingTest
//
//  Created by David Mansourian on 2022-11-28.
//

import Foundation

struct PhotoSearchModel: Decodable{
    let photos: PhotosResults
    let stat: String
}

struct PhotosResults: Decodable{
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [SinglePhoto]
}

struct SinglePhoto: Identifiable, Decodable{
    let id: String
    let owner: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
}
