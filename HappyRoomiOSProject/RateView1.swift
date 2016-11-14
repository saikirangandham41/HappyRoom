//
//  RateView.m
//  Custom
//
//  Created by Gandham,Sai Kiran on 10/8/16.
//  Copyright © 2016 Gandham,Sai Kiran. All rights reserved.
//
class RateView {

    func baseInit() {
        self.notSelectedImage = nil
        self.halfSelectedImage = nil
        self.fullSelectedImage = nil
        self.rating = 0
        self.editable = false
        self.imageViews = [Any]()
        self.maxRating = 5
        self.midMargin = 5
        self.leftMargin = 0
        self.minImageSize = CGSize(width: 5, height: 5)
        self.delegate = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.baseInit()
    
    }

    convenience required init?(coder aDecoder: NSCoder) {
        if (super.init(aDecoder)) {
            self.baseInit()
        }
    }

    override func refresh() {
        for i in 0..<self.imageViews.count {
            var imageView = self.imageViews[i]
            if self.rating >= i + 1 {
                imageView.image! = self.fullSelectedImage
            }
            else if self.rating > i {
                imageView.image! = self.halfSelectedImage
            }
            else {
                imageView.image! = self.notSelectedImage
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if self.notSelectedImage == nil {
            return
        }
        var desiredImageWidth: CGFloat = (self.frame.size.width - (self.leftMargin * 2) - (self.midMargin * self.imageViews.count)) / self.imageViews.count
        var imageWidth: CGFloat = MAX(self.minImageSize.width, desiredImageWidth)
        var imageHeight: CGFloat = MAX(self.minImageSize.height, self.frame.size.height)
        for i in 0..<self.imageViews.count {
            var imageView = self.imageViews[i]
            var imageFrame = CGRect(x: self.leftMargin + i * (self.midMargin + imageWidth), y: 0, width: imageWidth, height: imageHeight)
            imageView.frame = imageFrame
        }
    }

    func setMaxRating(_ maxRating: Int) {
        self.maxRating = maxRating
        // Remove old image views
        for i in 0..<self.imageViews.count {
            var imageView = (self.imageViews[i] as! UIImageView)
            imageView.removeFromSuperview()
        }
        self.imageViews.removeAll()
        // Add new image views
        for i in 0..<maxRating {
            var imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            self.imageViews.append(imageView)
            self.addSubview(imageView)
        }
        // Relayout and refresh
        self.setNeedsLayout()
        self.refresh()
    }

    func setNotSelectedImage(_ image: UIImage) {
        self.notSelectedImage = image
        self.refresh()
    }

    func setHalfSelectedImage(_ image: UIImage) {
        self.halfSelectedImage = image
        self.refresh()
    }

    func setFullSelectedImage(_ image: UIImage) {
        self.fullSelectedImage = image
        self.refresh()
    }

    override func setRating(_ rating: CGFloat) {
        self.rating = rating
        self.refresh()
    }

    func handleTouch(atLocation touchLocation: CGPoint) {
        if !self.editable {
            return
        }
        var newRating = 0
        var i = self.imageViews.count - 1
        while i >= 0 {
            var imageView = self.imageViews[i]
            if touchLocation.x > imageView.frame.origin.x {
                newRating = i + 1
            }
            i -= 1
        }
        self.rating = newRating
    }

    override func touchesBegan(_ touches: Set<AnyHashable>, withEvent event: UIEvent) {
        var touch = touches.first!
        var touchLocation = touch.location(in: self)
        self.handleTouch(atLocation: touchLocation)
    }

    override func touchesMoved(_ touches: Set<AnyHashable>, withEvent event: UIEvent) {
        var touch = touches.first!
        var touchLocation = touch.location(in: self)
        self.handleTouch(atLocation: touchLocation)
    }

    override func touchesEnded(_ touches: Set<AnyHashable>, withEvent event: UIEvent) {
        self.delegate!.rateView(self, ratingDidChange: self.rating)
    }
}