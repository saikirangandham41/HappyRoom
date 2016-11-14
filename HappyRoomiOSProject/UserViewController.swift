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

class UserViewController: UIViewController {
    
    
    
    @IBOutlet weak var rating: RateView!
    @IBOutlet weak var roomNumberTF: UITextField!
    
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var changeLBLText: UILabel!
    //  @IBOutlet weak var ratingTextLBL: UILabel!
    
    
    
    //Function to save the rating and review given for a room number by a user
    @IBAction func submitBTN(sender: AnyObject) {
        
        let roomNumber:Int! = Int(roomNumberTF.text!)
        if roomNumber != nil {
            let ratingInstance = Rating()
            
            ratingInstance.roomNumber = roomNumber
            ratingInstance.rating = rating.count
            
            displayMessage("Thank you for your rating")
            
            ratingInstance.saveInBackgroundWithBlock({ (success, error) -> Void in
                if success {
                    
                } else {
                    print(error)
                }
            })
        }
        else{
            displayMessage("Please enter a room number")
        }
        
        
    }
    func update () {
        dispatch_async(dispatch_get_main_queue(), {
            if self.rating.count == 1{
                self.changeLBLText.hidden = false
                self.changeLBLText.text = "Can be upgraded.!"
            }
            else if self.rating.count == 2{
                self.changeLBLText.hidden = false
                self.changeLBLText.text = "Bad"
            }
            else if self.rating.count == 3{
                self.changeLBLText.hidden = false
                self.changeLBLText.text = "Good"
            }
            else if self.rating.count == 4{
                self.changeLBLText.hidden = false
                self.changeLBLText.text = "Best"
            }
            else if self.rating.count == 5{
                self.changeLBLText.hidden = false
                self.changeLBLText.text = "Excellent"
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _ = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(UserViewController.update), userInfo: nil, repeats: true)
        changeLBLText.hidden = true
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

