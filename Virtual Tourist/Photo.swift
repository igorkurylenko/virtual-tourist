//
//  Photo.swift
//  Virtual Tourist
//
//  Created by kurilenko igor on 9/15/15.
//  Copyright (c) 2015 igor kurilenko. All rights reserved.
//

import Foundation
import CoreData

@objc(Photo)

class Photo: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var url: String
    @NSManaged var title: String
    @NSManaged var filePath: String?
    @NSManaged var pin: Pin?
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(id: String, url: String, title: String, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Photo", inManagedObjectContext: context)!
        
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.id = id
        self.url = url
        self.title = title
    }
    
    override func prepareForDeletion() {
        if let filePath = filePath {
            do{
                try NSFileManager.defaultManager().removeItemAtPath(filePath)
            } catch _ {
            }
        }
    }
}

extension Photo {
    
    class func create(dictionary: [String: AnyObject], pin: Pin, context: NSManagedObjectContext) -> Photo? {
        var result:Photo!
        
        if let id = dictionary["id"] as? String,
            let url = dictionary["url_m"] as? String,
            let title = dictionary["title"] as? String {
                result = Photo(id: id, url: url, title: title, context: context)
                result.pin = pin
        }
        
        return result
    }
}