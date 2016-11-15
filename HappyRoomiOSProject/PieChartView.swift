//
//  PieChartView.swift
//  HappyRoomiOSProject
//
//  Created by Gandham,Sai Kiran on 11/14/16.
//  Copyright © 2016 NWMSU. All rights reserved.
//

import UIKit
@IBDesignable

class PieChartView: UIView {
     /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func drawRect(rect: CGRect) {
        
                   let sliceRating5:UIBezierPath = UIBezierPath()
                sliceRating5.moveToPoint(CGPoint(x:150.0,y:150.0))
                sliceRating5.addArcWithCenter(CGPoint(x:150.0,y:150.0), radius: 150.0, startAngle: 0.0, endAngle: CGFloat(2*M_PI/5), clockwise: true)
        
                UIColor.blueColor().setFill()
        
                sliceRating5.fill()
        
                let sliceRating4:UIBezierPath = UIBezierPath()
                sliceRating4.moveToPoint(CGPoint(x:150.0,y:150.0))
                sliceRating4.addArcWithCenter(CGPoint(x:150.0,y:150.0), radius: 150.0, startAngle: CGFloat(2*M_PI/5), endAngle: CGFloat(4*M_PI/5), clockwise: true)
        
                UIColor.orangeColor().setFill()
                
                sliceRating4.fill()
        let sliceRating3:UIBezierPath = UIBezierPath()
        sliceRating3.moveToPoint(CGPoint(x:150.0,y:150.0))
        sliceRating3.addArcWithCenter(CGPoint(x:150.0,y:150.0), radius: 150.0, startAngle: CGFloat(4*M_PI/5), endAngle: CGFloat(6*M_PI/5), clockwise: true)
        
        UIColor.greenColor().setFill()
        
        sliceRating3.fill()
        
        let sliceRating2:UIBezierPath = UIBezierPath()
        sliceRating2.moveToPoint(CGPoint(x:150.0,y:150.0))
        sliceRating2.addArcWithCenter(CGPoint(x:150.0,y:150.0), radius: 150.0, startAngle: CGFloat(6*M_PI/5), endAngle: CGFloat(8*M_PI/5), clockwise: true)
        
        UIColor.yellowColor().setFill()
        
        sliceRating2.fill()
        let sliceRating1:UIBezierPath = UIBezierPath()
        sliceRating1.moveToPoint(CGPoint(x:150.0,y:150.0))
        sliceRating1.addArcWithCenter(CGPoint(x:150.0,y:150.0), radius: 150.0, startAngle: CGFloat(8*M_PI/5), endAngle: CGFloat(10*M_PI/5), clockwise: true)
        
        UIColor.redColor().setFill()
        
        sliceRating1.fill()

        

        

       

    }

}
