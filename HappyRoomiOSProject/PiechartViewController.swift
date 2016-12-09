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
import Charts

class PiechartViewController: UIViewController {
    
    @IBOutlet weak var pieView: PieChartView!
    var ratedRooms:[Int]! = []
    var givenRatings:[[Double]]! = []
    var roomsAndRatings:[Int:[Double]] = [:]
    var maxRating:Int = 0
    var averageRatingForRoom:[Double] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hotel.jpg")!)
        
        // Do any additional setup after loading the view.
    }
    
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
        averageRatingForRoom = []
        if Reachability.isConnectedToNetwork() == true {
            fetch()
        }
    }
    // fetching data from database and storing into arrays and dictonaries
    func fetch() {
        let query = PFQuery(className:"Rating")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                for object in objects!{
                    self.ratedRooms.append(object["roomNumber"] as! Int)
                    self.givenRatings.append(object["ratings"] as! NSArray as! [Double])
                }
                for i in 0 ..< self.ratedRooms.count{
                    self.roomsAndRatings[self.ratedRooms[i]] = self.givenRatings[i]
                }
                
                for value in self.roomsAndRatings.values{
                    self.averageRatingForRoom.append(self.getAverageRating(value))
                }
                var string:[String] = []
                for value in Array(Set(self.averageRatingForRoom)){
                    if value < 2{
                        string.append("Needs Renovation")
                    }
                    else if value >= 2.0 && value < 3{
                        string.append("Bad")
                    }
                    else if value >= 3.0 && value < 4{
                        string.append("Good")
                    }
                    else if value >= 4.0 && value < 5{
                        string.append("Best")
                    }
                    else if value == 5{
                        string.append("excellent")
                    }
                }
                if Array(Set(self.averageRatingForRoom)).count == 0{
                    
                }
                else{
                    self.setChart(string, values: Array(Set(self.averageRatingForRoom)))
                }
            }
            else {
                // Log details of the failure
                self.displayAlertWithTitle("Oops", message: "\(error!) \(error!.userInfo)")
            }
        }
        
    }
    // function for passing data and designing pie charts
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        
        pieView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        pieChartDataSet.colors = colors
        
    }
    
    
    // Pass in a String and it will be displayed in an alert view
    func displayAlertWithTitle(title:String, message:String){
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func displayMessage(message:String) {
        let alert = UIAlertController(title: "", message: message,
                                      preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title:"OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert,animated:true, completion:nil)
    }
    
}
