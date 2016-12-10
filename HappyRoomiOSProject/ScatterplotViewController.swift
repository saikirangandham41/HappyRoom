//
//  SecondViewController.swift
//  HappyRoomiOSProject
//
//  Created by Gandham,Sai Kiran on 10/6/16.
//  Copyright © 2016 NWMSU. All rights reserved.
//

import UIKit
import CoreData
import Charts
import Parse
import Bolts

class ScatterplotViewController: UIViewController {
    
    
    @IBOutlet weak var scatterPlotView: ScatterPlotView!
    var ratingsForRoom:[Int:[Double]]! = [:]
    var averageRatingForRoom:[Int:Double]! = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hotel.jpg")!)
        fetch()
        // Do any additional setup after loading the view.
    }
    
    // function to get averageRating
    func getAverageRating(ratings:[Double])-> Double {
        var sum:Double = 0.0
        var averageRating:Double = 0.0
        for rating in ratings {
            sum += Double(rating)
        }
        averageRating = sum/Double(ratings.count)
        return averageRating
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if Reachability.isConnectedToNetwork() == true {
            fetch()
        }
    }
    
    // function for fetching data from database and stored in database
    func fetch() {
        let query = PFQuery(className:"Rating")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                for object in objects!{
                    //adding extracted objects into ratingsForRoom Dictionary
                    self.ratingsForRoom[object["roomNumber"] as! Int] = object["ratings"] as! NSArray as? [Double]
                }
                //calculating averageRating and storing in averageRatingForRoom array
                for room in self.ratingsForRoom.keys{
                    self.averageRatingForRoom[room] = self.getAverageRating(self.ratingsForRoom[room]!)
                }
                // passing averageRatingForRoom to ScatterPlotView
                self.scatterPlotView.getMeData(self.averageRatingForRoom)
            }
            else {
                // Log details of the failure
                self.displayAlertWithTitle("Oops", message: "\(error!) \(error!.userInfo)")
            }
        }
        
    }
    // function for handling pinch gesture
    @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransformScale(view.transform,
                                                    recognizer.scale, recognizer.scale)
            recognizer.scale = 1
        }
    }
    // function for handling rotate gesture
    @IBAction func handleRotate(recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransformRotate(view.transform, recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    // Pass in a String and it will be displayed in an alert view
    func displayAlertWithTitle(title:String, message:String){
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    // display message
    func displayMessage(message:String) {
        let alert = UIAlertController(title: "", message: message,
                                      preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title:"OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert,animated:true, completion:nil)
    }
    
}

