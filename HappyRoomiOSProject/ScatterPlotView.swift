//
//  ScatterPlotView.swift
//  HappyRoomiOSProject
//
//  Created by Gandham,Sai Kiran on 11/14/16.
//  Copyright © 2016 NWMSU. All rights reserved.
//

import UIKit
@IBDesignable
class ScatterPlotView: UIView {
    
    var ratingForRoom:[Int:Double]! = [:]
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        var square:UIBezierPath
        let width = Double(bounds.width)
        let height = Double(bounds.height)
        // displays four rows and columns
        for i in 0 ..< 4{
            for j in 0 ..< 5{
                square = UIBezierPath(rect: CGRect(x:(i * Int(width/4)), y: (j*Int(height/6)), width: Int(width/4) , height: Int(height/6)))
                square.lineWidth = 0.5
                square.stroke()
                UIColor.whiteColor().setFill()
                square.fill()
            }
        }
        // Array of colors
        let colorSpectrum = [UIColor.grayColor(),  UIColor.brownColor(), UIColor.blackColor(),UIColor.blueColor(),UIColor.purpleColor(),UIColor.cyanColor(),UIColor.darkGrayColor()]
        
        // function to draw 'x' which represents average rating between 1 and 2
        func drawX( pointX:Double, _ pointY:Double){
            let symbolX = UIBezierPath()
            let randomColor = colorSpectrum[Int(arc4random_uniform(7))]
            symbolX.moveToPoint(CGPoint(x:0.0 + pointX, y:(5*height/6 ) + pointY))
            symbolX.addLineToPoint(CGPoint(x: 10.0  + pointX,y: (5*height/6 - 8) + pointY))
            symbolX.moveToPoint(CGPoint(x: 10.0 + pointX, y:(5*height/6 ) + pointY))
            symbolX.addLineToPoint(CGPoint(x:0.0 + pointX,y:(5*height/6 - 8) + pointY))
            randomColor.setStroke()
            symbolX.stroke()
        }
        // function to draw circle which represents average rating between 2 and 3
        func drawCircle(pointX:Double, _ pointY:Double){
            let randomColor = colorSpectrum[Int(arc4random_uniform(7))]
            let circle = UIBezierPath(ovalInRect: CGRect(x: 0.0 + pointX, y: 4*height/6 - 8 + pointY,width: 8,height: 8))
            randomColor.setFill()
            circle.fill()
        }
        // function to draw triangle which represents average rating between 3 and 4
        func drawTriangle(pointX:Double, _ pointY:Double){
            let triangle:UIBezierPath = UIBezierPath()
            let randomColor = colorSpectrum[Int(arc4random_uniform(7))]
            triangle.moveToPoint(CGPoint(x:0.0 + pointX, y:3*height/6 - 8 + pointY))
            triangle.addLineToPoint(CGPoint(x: 10 + pointX , y:3*height/6 - 8 + pointY))
            triangle.addLineToPoint(CGPoint(x:5  + pointX , y:3*height/6 - 8 - 7 + pointY))
            triangle.closePath()
            randomColor.setFill()
            triangle.fill()
        }
        // function to draw spark which represents average rating 4 and 5
        func drawSpark(pointX:Double, _ pointY:Double){
            let spark:UIBezierPath = UIBezierPath()
            let randomColor = colorSpectrum[Int(arc4random_uniform(7))]
            spark.moveToPoint(CGPoint(x:0.0 + pointX , y:2*height/6 + pointY))
            spark.addLineToPoint(CGPoint(x: 10 + pointX , y:2*height/6 - 10 + pointY))
            spark.addLineToPoint(CGPoint(x:0.0 + pointX , y:2*height/6 - 10 + pointY))
            spark.addLineToPoint(CGPoint(x:10 + pointX , y:2*height/6 - 20 + pointY))
            spark.closePath()
            randomColor.setFill()
            spark.fill()
        }
        // function to draw star which represents rating 5
        func drawStar(pointX:Double, _ pointY:Double){
            let stableTriangle:UIBezierPath = UIBezierPath()
            let randomColor = colorSpectrum[Int(arc4random_uniform(7))]
            stableTriangle.moveToPoint(CGPoint(x:0.0 + pointX, y:height/6 + pointY + 2))
            stableTriangle.addLineToPoint(CGPoint(x: 15 + pointX , y:height/6 + pointY + 2))
            stableTriangle.addLineToPoint(CGPoint(x:7.5 + pointX , y:height/6 - 12 + pointY + 2))
            stableTriangle.closePath()
            randomColor.setFill()
            stableTriangle.fill()
            let lowerTriangle:UIBezierPath = UIBezierPath()
            lowerTriangle.moveToPoint(CGPoint(x:7.5 + pointX ,y:height/6 + 4 + pointY + 2))
            lowerTriangle.addLineToPoint(CGPoint(x:15 + pointX, y:height/6 - 8 + pointY + 2))
            lowerTriangle.addLineToPoint(CGPoint(x:0.0 + pointX,y:height/6 - 8 + pointY + 2))
            lowerTriangle.closePath()
            randomColor.setFill()
            lowerTriangle.fill()
        }
        // method for checking room number and plotting symbols in the view
        for roomNumber in ratingForRoom.keys{
            
            let rating:Double = ratingForRoom[roomNumber]!
            let pointX:Double = Double(roomNumber%100)*1.6
            let movePointYBy = (rating - Double(Int(rating)))*10
            let pointY = -10*movePointYBy
            switch true{
            case roomNumber > 100 && roomNumber < 200: // if room number is between 100 and 200
                switch true {
                case rating < 2.0:
                    drawX(pointX, pointY)
                case rating >= 2.0 && rating < 3.0:
                    drawCircle(pointX ,pointY)
                case rating >= 3.0 && rating < 4.0:
                    drawTriangle(pointX ,pointY)
                case rating >= 4.0 && rating < 5.0:
                    drawSpark(pointX ,pointY)
                case rating == 5:
                    drawStar(pointX ,pointY )
                default:
                    drawCircle(pointX,pointY)
                }
            case roomNumber >= 200 && roomNumber < 300: // if room number is between 200 and 300
                switch true {
                case rating < 2.0:
                    drawX(pointX + width/4 , pointY)
                case rating >= 2.0 && rating < 3.0:
                    drawCircle(pointX +  width/4,pointY )
                case rating >= 3.0 && rating < 4.0:
                    drawTriangle(pointX +  width/4 ,pointY)
                case rating >= 4.0 && rating < 5.0:
                    drawSpark(pointX +  width/4 ,pointY)
                case rating == 5:
                    drawStar(pointX + width/4,pointY)
                default:
                    drawCircle(pointX,pointY)
                }
            case roomNumber >= 300 && roomNumber < 400: // if room number is between 300 and 400
                switch true {
                case rating < 2.0:
                    drawX(pointX + width/2, pointY)
                case rating >= 2.0 && rating < 3.0:
                    drawCircle(pointX + width/2,pointY)
                case rating >= 3.0 && rating < 4.0:
                    drawTriangle(pointX + width/2,pointY)
                case rating >= 4.0 && rating < 5.0:
                    drawSpark(pointX + width/2,pointY)
                case rating == 5:
                    drawStar(pointX + width/2,pointY)
                default:
                    drawCircle(pointX,pointY)
                }
            case roomNumber >= 400 && roomNumber < 500: // if room number is between 400 and 500
                
                switch true {
                case rating < 2.0:
                    drawX(pointX + 3*width/4   ,pointY)
                case rating >= 2.0 && rating < 3.0:
                    drawCircle(pointX + 3*width/4 ,pointY)
                case rating >= 3.0 && rating < 4.0:
                    drawTriangle(pointX + 3*width/4 ,pointY)
                case rating >= 4.0 && rating < 5.0:
                    drawSpark(pointX + 3*width/4 ,pointY)
                case rating == 5:
                    drawStar(pointX + 3*width/4 ,pointY)
                default:
                    drawCircle(pointX,pointY)
                }
            default:
                false
                
            }
            
        }
    }
    
    // function which assgins average ratings from ScatterViewController
    func getMeData(roomRatings:[Int:Double]){
        ratingForRoom = roomRatings
        setNeedsDisplay()
    }
    
}

    