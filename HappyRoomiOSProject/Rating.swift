//
//  Rating.swift
//  HappyRoomiOSProject
//
//  Created by Gopavaram,Giri Rakesh on 10/26/16.
//  Copyright © 2016 NWMSU. All rights reserved.
//

import Foundation
import Parse
import Bolts
class Rating:PFObject, PFSubclassing {

    @NSManaged var roomNumber:Int
    @NSManaged var rating:Int
    
    
    static func parseClassName() -> String {
        return "Rating"
    }
}