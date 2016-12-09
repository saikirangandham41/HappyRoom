//
//  ContentViewController.swift
//  HappyRoomiOSProject
//
//  Created by Gopavaram,Giri Rakesh on 11/14/16.
//  Copyright © 2016 NWMSU. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var introductionTeV: UITextView!
    
    let userInstance = UserViewController()
    var pageIndex: Int!
    var titleText:String!
    var imageFile: String!
    var introductionText:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork() == true {
            userInstance.fetch()
        } else {
            displayMessage("Please check your internet connection")
        }
        
        // Do any additional setup after loading the view.
        
        self.imageView.image = UIImage(named: self.imageFile)
        self.titleLabel.text = self.titleText
        self.introductionTeV.textColor = UIColor.whiteColor()
        self.introductionTeV.text = self.introductionText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func displayMessage(message:String) {
        let alert = UIAlertController(title: "", message: message,
                                      preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title:"OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert,animated:true, completion:nil)
    }

    
}
