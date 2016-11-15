//
//  PiechartViewController.swift
//  HappyRoomiOSProject
//
//  Created by Gandham,Sai Kiran on 10/6/16.
//  Copyright © 2016 NWMSU. All rights reserved.
//

import UIKit
import Parse
import Bolts
import CoreData

class PiechartViewController: UIViewController {
    
    var dataArrayWithRoomNumber:NSMutableArray = []
    var dataArrayWithRoomStrings:NSMutableArray = []
    var dataArrayWithRating:NSMutableArray = []

    var dataDictionary:[String: [Int]] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func fetch() {
        let query = PFQuery(className:"Rating")
              query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                for object in objects!{
                    
                    self.dataArrayWithRoomNumber.addObject(object["roomNumber"] as! Int)
                    self.dataArrayWithRating.addObject(object["rating"] as! Int)
                   // dataDictionary[(dataArrayWithRoomNumber as? Int)!].append(dataArrayWithRating)
                   
                }
                    }
            else {
                // Log details of the failure
                self.displayAlertWithTitle("Oops", message: "\(error!) \(error!.userInfo)")
            }
               
                for roomNumber in 0 ..< self.dataArrayWithRoomNumber.count{
                    self.dataArrayWithRoomStrings.addObject(String(self.dataArrayWithRoomNumber[(roomNumber)]))
                    
                }
                for roomNumber in 0 ..< self.dataArrayWithRoomNumber.count {
//                    self.dataDictionary[self.dataArrayWithRoomStrings[roomNumber] as! String] = [self.dataArrayWithRating.addObject(roomNumber)] as! [[Int]]
                    //print(self.dataArrayWithRoomNumber[roomNumber])
                }
               // print(self.dataDictionary)
//
        }
    }
    
    // Pass in a String and it will be displayed in an alert view
    func displayMessage(message:String) {
        let alert = UIAlertController(title: "", message: message,
                                      preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title:"OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert,animated:true, completion:nil)
    }
    
    // Pass in a String and it will be displayed in an alert view
    func displayAlertWithTitle(title:String, message:String){
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

    
}
