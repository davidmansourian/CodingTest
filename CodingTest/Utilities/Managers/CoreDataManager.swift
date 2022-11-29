//
//  CoreDataManager.swift
//  CodingTest
//
//  Created by David on 2022-11-29.
//

import Foundation
import CoreData
import Combine
import SwiftUI


class CoreDataManager: ObservableObject{
    static let shared = CoreDataManager()
    var moc = PersistenceController.shared.container.viewContext
    @FetchRequest(sortDescriptors: []) var likedImages: FetchedResults<Item>
    private var cancellable: Cancellable?
    
    private init(){}
    
    func photoIsLiked(urlString: String, keyString: String) -> Bool {
        let fetchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "imageUrl == %@ AND imageKey == %@", urlString, keyString)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        do{
            let count = try moc.count(for: fetchRequest)
            
            if count == 0{
                return false
            }
            else{
                return true
            }
        } catch let error as NSError{
            print("Could not fetch \(error) \(error.userInfo)")
        }
        return true
    }
    
    
    func likeUnlikeImage(urlString: String, keyString: String){
        if !photoIsLiked(urlString: urlString, keyString: keyString){
            let image = Item(context: moc)
            image.recordId = UUID()
            image.imageUrl = urlString
            image.imageKey = keyString
            try? moc.save()
        }
        else if photoIsLiked(urlString: urlString, keyString: keyString){
            for image in likedImages{
                if image.imageKey == keyString{
                    moc.delete(image)
                }
            }
            
            try? moc.save()
        }
    }
    
    
}
