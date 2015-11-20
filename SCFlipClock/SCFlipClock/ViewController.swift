//
//  ViewController.swift
//  SCFlipClock
//
//  Created by ZhangSC on 15/11/20.
//  Copyright © 2015年 FYTech. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    var flip: SCFlipView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let flipView = SCFlipView.init(image: UIImage(named: "1.jpg")!, frame: CGRectMake(0, 0, 200, 200))
        flipView.center = self.view.center
        self.view.addSubview(flipView)
        flip = flipView
        let button = UIButton.init(frame: CGRectMake(0, 0, 50, 50))
        button.addTarget(self, action: Selector("click:"), forControlEvents:.TouchUpInside)
        button.backgroundColor = UIColor.blueColor()
        self.view.addSubview(button)
    }
    
    func click(sender: UIButton) {
//        flip!.flip()
        let angle = CGFloat(M_PI)
        var trans = CATransform3DMakeRotation(angle, 1.0, 0, 0)
        trans.m34 = -1 / 500.0
        
        //        let baseAnimation = CABasicAnimation()
        //        baseAnimation.duration = 1.0
        //        baseAnimation.repeatCount = HUGE
        //        baseAnimation.keyPath = "transform"
        //        baseAnimation.toValue = NSValue.init(CATransform3D: trans)
        //        topLayer.addAnimation(baseAnimation, forKey: "Flip")
        UIView.animateWithDuration(7.0) { () -> Void in
            self.flip?.topLayer.transform = trans
            self.view.setNeedsDisplay()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

