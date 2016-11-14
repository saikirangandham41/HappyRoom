//
//  ViewController.swift
//  HappyRoomiOSProject
//
//  Created by Gopavaram,Giri Rakesh on 11/14/16.
//  Copyright © 2016 NWMSU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func viewControllerAtIndex(index:Int) -> ContentViewController{
        if self.pageTitles.count == 0 || index >= self.pageTitles.count{
            return ContentViewController()
        }
//        var vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("") as as ContentViewController
        return ContentViewController()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
