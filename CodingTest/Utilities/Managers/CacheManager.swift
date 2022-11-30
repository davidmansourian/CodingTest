//
//  CacheManager.swift
//  CodingTest
//
//  Created by David on 2022-11-29.
//

import Foundation
import SwiftUI

// cahcemanager implemented with the help of video: https://www.youtube.com/watch?v=yXSC6jTkLP4


class CacheManager: ObservableObject{
    static let shared = CacheManager()
    
    private init(){}
    
    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func add(key: String, value: UIImage){
        print("DEBUG: added cached item with key \(key)")
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage?{
        print("DEBUG: fetching cached item with key \(key)")
        return photoCache.object(forKey: key as NSString)
    }
}
