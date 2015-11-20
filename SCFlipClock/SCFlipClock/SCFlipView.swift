//
//  SCFlipView.swift
//  SCFlipClock
//
//  Created by ZhangSC on 15/11/20.
//  Copyright © 2015年 FYTech. All rights reserved.
//

import Foundation
import UIKit


class SCFlipView: UIView {
    
    let image: UIImage
    let space = CGFloat(2.5)   //中间空隙
    let topLayer = CALayer()
    let bottomLayer = CALayer()
    var width:CGFloat {
        return self.bounds.width
    }
    var height:CGFloat {
        return self.bounds.height
    }
    
    init(image: UIImage, frame: CGRect) {
        self.image = image
        super.init(frame: frame)
        commomInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commomInit() {
        
        topLayer.bounds = CGRectMake(0, 0, width, height / 2 - space)
        bottomLayer.bounds = CGRectMake(0, 0, width, height / 2 - space)
        topLayer.position = CGPointMake(width / 2, height / 2 - space)
        bottomLayer.position = CGPointMake(width / 2, height / 2 + space)
        
        topLayer.zPosition = 0
        bottomLayer.zPosition = -100
    
        topLayer.contentsRect = CGRectMake(0, 0, 1.0, 0.5)
        bottomLayer.contentsRect = CGRectMake(0, 0.5, 1.0, 0.5)
        
        topLayer.anchorPoint = CGPointMake(0.5, 1)
        bottomLayer.anchorPoint = CGPointMake(0.5, 0)
        
        initLayer(topLayer)
        initLayer(bottomLayer)
        self.layer.addSublayer(topLayer)
        self.layer.addSublayer(bottomLayer)
//        flip()
    }
    
    func initLayer(layer: CALayer) {
        layer.shouldRasterize = true
        layer.contents = image.CGImage
    }
    
    func flip() {
        let angle = CGFloat(M_PI)
        var trans = CATransform3DMakeRotation(angle, 1.0, 0, 0)
        trans.m34 = -1 / 500.0
        
//        let baseAnimation = CABasicAnimation()
//        baseAnimation.duration = 1.0
//        baseAnimation.repeatCount = HUGE
//        baseAnimation.keyPath = "transform"
//        baseAnimation.toValue = NSValue.init(CATransform3D: trans)
//        topLayer.addAnimation(baseAnimation, forKey: "Flip")
        UIView.animateWithDuration(2.0) { () -> Void in
            self.topLayer.transform = trans
            
        }
    }
}