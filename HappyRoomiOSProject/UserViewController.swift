//
//  FirstViewController.swift
//  HappyRoomiOSProject
//
//  Created by Gandham,Sai Kiran on 10/6/16.
//  Copyright © 2016 NWMSU. All rights reserved.
//

import UIKit
import Bolts
import Parse
import CoreData
import Charts

class UserViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    var givenRating:Int = 0
    var ratedRooms:[Int]! = []
    var givenRatings:[[Int]]! = []
    var roomsAndRatings:[Int:[Int]] = [:]
    let scatterVC:ScatterplotViewController = ScatterplotViewController() // object for ScatterplotViewController
    @IBOutlet weak var ratingView: RateView!
    @IBOutlet weak var roomNumberTF: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var changeLBLText: UILabel!
    
    
    // fetching data from database and storing in arrays and dictionary
    func fetch()  {
        let query = PFQuery(className:"Rating")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                for object in objects!{
                    self.ratedRooms.append(object["roomNumber"] as! Int)
                    self.givenRatings.append(object["ratings"] as! NSArray as! [Int])
                    
                }
                for i in 0 ..< self.ratedRooms.count{
                    self.roomsAndRatings[self.ratedRooms[i]] = self.givenRatings[i]
                }
                
            }
            else {
                // Log details of the failure
                self.displayAlertWithTitle("Oops", message: "\(error!) \(error!.userInfo)")
            }
        }
    }
    
    
    
    //Function to save the rating and review given for a room number by a user
    @IBAction func submitBTN(sender: AnyObject) {
        
        let roomNumber:Int! = Int(roomNumberTF.text!)
        if roomNumber != nil{
            if roomNumber > 99 && roomNumber < 500{
                givenRating = ratingView.count
                if givenRating != 0 {
                    let query = Rating.queryWithRoomNumber(roomNumber)
                    query?.findObjectsInBackgroundWithBlock({ (ratings: [PFObject]?, error:NSError?) in
                        if error == nil {
                            if ratings?.count == 1 {
                                for rating in ratings! {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        (rating as! Rating).addObjectsFromArray([self.givenRating], forKey: "ratings")
                                        rating.saveInBackground()
                                    }
                                }
                            } else {
                                let newRoomRating = Rating(roomNumber: roomNumber)
                                newRoomRating.ratings.append(self.givenRating)
                                newRoomRating.saveInBackgroundWithBlock({ (success, error) -> Void in
                                    if success {
                                        print("Successfully saved Rating for room No: \(roomNumber)")
                                    } else {
                                        
                                        if let error = error {
                                            print("Something terrible happened. Something like \(error.localizedDescription)")
                                        }
                                    }
                                })
                            }
                        }
                        
                    })
                    
                }
                
                if (ratingView.rating) == 0 {
                    displayMessage("Please consider rating the room.!")
                }
                else{
                    displayMessage("We've made your rating count...!") // if everything is entered and submitted
                    updateTextFields()
                }
                
            }
            else{
                displayMessage("Please enter a room number between 100 and 500") // validation message
                updateTextFields()
            }
        }
        else{
            displayMessage("Please enter a room number between 100 and 500") // validation message
            updateTextFields()
        }
        
        
    }
    
    // method to clear text fields in UserViewController
    func updateTextFields() {
        roomNumberTF.text = ""
        textViewDidEndEditing(descriptionText)
        ratingView.rating = 0
        changeLBLText.text = ""
        roomNumberTF.resignFirstResponder()
        //        descriptionText.resignFirstResponder()
    }
    // displays text below the rating view
    func update () {
        dispatch_async(dispatch_get_main_queue(), {
            if self.ratingView.count == 1{
                self.changeLBLText.hidden = false
                self.changeLBLText.text = "Needs renovation😞"
            }
            else if self.ratingView.count == 2{
                self.changeLBLText.hidden = false
                self.changeLBLText.text = "Bad"
            }
            else if self.ratingView.count == 3{
                self.changeLBLText.hidden = false
                self.changeLBLText.text = "Good"
            }
            else if self.ratingView.count == 4{
                self.changeLBLText.hidden = false
                self.changeLBLText.text = "Best"
            }
            else if self.ratingView.count == 5{
                self.changeLBLText.hidden = false
                self.changeLBLText.text = "Can I live here!"
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomNumberTF.delegate = self
        descriptionText.delegate = self
        descriptionText.clipsToBounds = true
        descriptionText.layer.cornerRadius = (10.0)
        descriptionText.text = "We'd like to hear from you.."
        descriptionText.textColor = UIColor.lightGrayColor()
        // Do any additional setup after loading the view, typically from a nib.
        _ = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(UserViewController.update), userInfo: nil, repeats: true)
        changeLBLText.hidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hotel.jpg")!)
        // scatterVC.fetch()
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            displayMessage("You are not connected to the internet")
        }
    }
    override func viewWillAppear(animated: Bool) {
        
        if Reachability.isConnectedToNetwork() == true {
            fetch()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // method for tapGestureRecognizer
    @IBAction func handleTap(recognizer:UITapGestureRecognizer){
        if descriptionText.text.isEmpty{
            //descriptionText.text = "We'd like to hear from you"
            //textViewDidEndEditing(descriptionText)
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if descriptionText.textColor == UIColor.lightGrayColor() {
            descriptionText.text = ""
            descriptionText.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if descriptionText.text.isEmpty {
            descriptionText.text = "We'd like to hear from you.."
            descriptionText.textColor = UIColor.lightGrayColor()
        } else {
            descriptionText.text = ""
            descriptionText.resignFirstResponder()
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
        // alert.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
}

