//
//  ViewController.swift
//  HappyRoomiOSProject
//
//  Created by Gopavaram,Giri Rakesh on 11/14/16.
//  Copyright © 2016 NWMSU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!
    var introductionText:NSArray!
    
    var introductionForRating:String = " Give rating to a hotel room"
    var introductionForPie:String = "View the rating statistics in a pie chart"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageTitles = NSArray(objects:"Introduction", "Introduction" )
        self.pageImages = NSArray(objects: "User", "Pie")
        
        self.introductionText = NSArray(objects: "\(introductionForRating)","\(introductionForPie)")
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as ContentViewController
        let viewControllers = NSArray(objects: startVC)
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.height-60)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // function for displaying images in the content view controller
    func viewControllerAtIndex(index:Int) -> ContentViewController{
        if self.pageTitles.count == 0 || index >= self.pageTitles.count{
            return ContentViewController()
        }
        let vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        vc.imageFile = self.pageImages[index] as! String
        vc.titleText = self.pageTitles[index] as! String
        vc.introductionText = self.introductionText[index] as! String
        vc.pageIndex = index
        return vc
    }
    // function for updating index value
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        if index == 0 || index ==  NSNotFound {
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    // function for updating index value
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc  = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        if index ==  NSNotFound {
            return nil
        }
        index += 1
        
        if index == self.pageTitles.count{
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
