//
//  RateView.h
//  Custom
//
//  Created by Gandham,Sai Kiran on 10/8/16.
//  Copyright © 2016 Gandham,Sai Kiran. All rights reserved.
//
import UIKit

// class for rating 5 stars
class RateView: UIView {
    var user:UserViewController = UserViewController()
    var count:Int! = 0
    var tapped:Bool = false
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    var spacing = 5
    var stars = 5
    
    // MARK: Initialization
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        let filledStarImage = UIImage(named: "filledStar1")
        let emptyStarImage = UIImage(named: "emptyStar10")
        
        for _ in 0..<5 {
            let button = UIButton()
            
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: #selector(RateView.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }
        
    }
    
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    
    // function triggers when we tap on the stars
    func ratingButtonTapped(button: UIButton)-> Bool{
        
        rating = ratingButtons.indexOf(button)! + 1
        updateButtonSelectionStates()
        tapped = true
        
        return true
    }
    // function to update stars
    func updateButtonSelectionStates()->Int {
        for (index, button) in ratingButtons.enumerate() {
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
            count = rating
        }
        return count
    }
    
    
}

