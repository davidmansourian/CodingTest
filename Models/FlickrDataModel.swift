//
//  FlickrDataModel.swift
//  CodingTest
//
//  Created by David Mansourian on 2022-11-28.
//

import Foundation

struct PhotoSearchModel: Decodable{
    let photos: Photos
    let stat: String
}

struct Photos: Decodable{
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}

struct Photo: Decodable{
    let id: String
    let owner: String
    let Server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
}
