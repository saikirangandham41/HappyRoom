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
class Rating:PFObject {
    
    @NSManaged var roomNumber:Int
    @NSManaged var ratings:[Int]!
    
    init(roomNumber:Int) {
        super.init()
        self.roomNumber = roomNumber
        self.ratings = []
    }
    
    override init() {
        super.init()
    }
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Rating.parseClassName())
        query.includeKey("user")
        return query
    }
    class func queryWithRoomNumber(roomNumber:Int) -> PFQuery? {
        //        let predicate = NSPredicate(format: "roomNumber = %@", String(roomNumber))
        let query = PFQuery(className: Rating.parseClassName())
        query.whereKey("roomNumber", equalTo: roomNumber)
        //        query.includeKey("user")
        return query
    }
}
extension Rating : PFSubclassing {
    
    class func parseClassName() -> String {
        return "Rating"
    }
}