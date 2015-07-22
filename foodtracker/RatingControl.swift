//
//  RatingControl.swift
//  foodtracker
//
//  Created by blackbeans on 7/16/15.
//  Copyright (c) 2015 blackbeans. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var rating = 0{
        didSet{
            setNeedsLayout()
        }
    }
    var rationButtons = [UIButton]()
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let emptyStar = UIImage(named: "emptyStar")
        let filledStar  = UIImage(named: "filledStar")
        
        
        for _ in 0...4{
            
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            

            
//        button.backgroundColor = UIColor.redColor()
            button.setImage(emptyStar, forState: .Normal)
            button.setImage(filledStar, forState: .Selected)
            button.setImage(filledStar, forState: UIControlState.Selected|UIControlState.Highlighted)
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: UIControlEvents.TouchDown)
        
        addSubview(button)
        rationButtons+=[button]
        }
    }
    
    override func layoutSubviews() {
        var buttonFrame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        var i = 0
        for bt in rationButtons{
           buttonFrame.origin.x = CGFloat(i * (44+5))
           bt.frame = buttonFrame
            i++
        }
        
         refreshSelectedStatus()
    }
    
    
    func refreshSelectedStatus(){
        
        var i = 0
        for bt in rationButtons{
            
            bt.selected = i < self.rating

            i++
        }
    
    }

    
    func ratingButtonTapped(button :UIButton){
//        println("Button Pressed 👍")
        
        for i in 0...self.rationButtons.count{
            //select button
            self.rationButtons[i].selected=true
            if ( rationButtons[i] == button){
                self.rating=i+1
                break
            }
        }
        
        refreshSelectedStatus()
    }
    
}
