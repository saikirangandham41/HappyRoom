//
//  PieChartView.swift
//  HappyRoomiOSProject
//
//  Created by Gandham,Sai Kiran on 11/14/16.
//  Copyright © 2016 NWMSU. All rights reserved.
//

import UIKit
@IBDesignable

class PiechartView: UIView {
    
    let userInstance = UserViewController()
    var roomDictionary = [Int:[Int]]()
    var maxRating:Int = 0
    override func drawRect(rect: CGRect) {
        dispatch_async(dispatch_get_main_queue(),{
            self.getRatingData(self.roomDictionary,getRating: self.maxRating)
            })

     // delayDraw()

        
        if self.maxRating > 0{
            for i in 0 ... self.maxRating - 1 {
                let double:Double = Double(self.maxRating)
                let sliceRating:UIBezierPath = UIBezierPath()
                sliceRating.moveToPoint(CGPoint(x:150.0,y:150.0))
                sliceRating.addArcWithCenter(CGPoint(x:150.0,y:150.0), radius: 150.0, startAngle: 0.0 + CGFloat(i)*CGFloat(2*M_PI/double), endAngle: CGFloat(2*M_PI/double) + CGFloat(i)*CGFloat(2*M_PI/double), clockwise: true)
                switch i {
                case 0:
                    UIColor.blueColor().setFill()
                case 1:
                    UIColor.orangeColor().setFill()
                case 2:
                    UIColor.brownColor().setFill()
                case 3:
                    UIColor.cyanColor().setFill()
                case 4:
                    UIColor.redColor().setFill()
                default:
                    UIColor.blueColor().setFill()
                }
                sliceRating.fill()
            }
        }
        else{
            let sliceRating:UIBezierPath = UIBezierPath()
            sliceRating.moveToPoint(CGPoint(x:150.0,y:150.0))
            sliceRating.addArcWithCenter(CGPoint(x:150.0,y:150.0), radius: 150.0, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: true)
            UIColor.grayColor().setFill()
            sliceRating.fill()
        }
        
        
    }
    func getRatingData(dictionary:[Int:[Int]],getRating:Int){
        roomDictionary = dictionary
        maxRating = getRating
        setNeedsDisplay()
    }
   
    func delayDraw(){
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            print("test")
        }
        
        setNeedsDisplay()
    }
}
