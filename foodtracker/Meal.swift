//
//  Meal.swift
//  foodtracker
//
//  Created by blackbeans on 7/17/15.
//  Copyright (c) 2015 blackbeans. All rights reserved.
//

import Foundation
import UIKit



class Meal: NSObject, NSCoding {
    
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
        
    }

    var name:String
    var rating : Int
    var photo : UIImage?

    static let documentsDir: AnyObject = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask,true).first!
    static let archivepath = documentsDir.stringByAppendingPathComponent("meals")
    
     required convenience init(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        self.init(name: name,photo: photo,rating: rating)
    }
    
     init(name :String,photo :UIImage?,rating : Int){

        
        self.name = name
        self.photo = photo
        self.rating = rating
        super.init()
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name,forKey:PropertyKey.nameKey)
        aCoder.encodeObject(photo,forKey:PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    
}

