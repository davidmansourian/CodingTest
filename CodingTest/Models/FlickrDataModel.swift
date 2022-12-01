//
//  FlickrDataModel.swift
//  CodingTest
//
//  Created by David Mansourian on 2022-11-28.
//

import Foundation
import SwiftUI

struct PhotoSearchModel: Decodable{
    let photos: PhotosResults
    let stat: String
}

struct PhotoResultModel: Decodable{
    let photo: PhotoDetail
    let stat: String
}

struct PhotosResults: Decodable{
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [SinglePhoto]
}

struct SinglePhoto: Hashable, Identifiable, Decodable{
    let id: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    var url: String?
}


struct PhotoDetail: Decodable{
    let title: Comments
    let photoDescription: Comments
    let owner: Owner
    let dateuploaded: String
    
    enum CodingKeys: String, CodingKey {
         case title, owner, dateuploaded
         case photoDescription = "description"
     }
}

struct Comments: Decodable {
    let content: String
    
    enum CodingKeys: String, CodingKey {
            case content = "_content"
        }
}

struct Owner: Decodable {
    let username: String

    enum CodingKeys: String, CodingKey {
        case username
    }
}
