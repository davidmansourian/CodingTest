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
    private var cancellable: Cancellable?
    @Published var likedPhotoData: [Item] = []
    
    private init(){}
    
    func fetchLikedData(){
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        var fetchedData: [Item] = []
        
        do {
            fetchedData = try moc.fetch(fetchRequest)
        } catch let error {
            print ("DEBUG: Error fetching all data", error)
        }
        
        self.likedPhotoData.removeAll()
        self.likedPhotoData = fetchedData
    }
    
    func photoIsLiked(urlString: String, keyString: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
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
            print("DEBUG: Could not fetch \(error) \(error.userInfo)")
        }
        return true
    }
    
    func likeUnlikeImage(urlString: String, keyString: String){
        if !photoIsLiked(urlString: urlString, keyString: keyString){
            let image = Item(context: moc)
            image.imageUrl = urlString
            image.imageKey = keyString
            try? moc.save()
        }
        else if photoIsLiked(urlString: urlString, keyString: keyString){
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
            let predicate = NSPredicate(format: "imageKey == %@", keyString)
            fetchRequest.predicate = predicate
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do{
                try moc.execute(deleteRequest)
                try moc.save()
                
            } catch {
                print("DEBUG: Couldn't delete row in database", error)
            }
        }
    }
    
    
}

