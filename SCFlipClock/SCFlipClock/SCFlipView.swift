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
    
    let imageKey: String
    let image: UIImage
    let space = CGFloat(2.5)          //中间空隙
    let topLayer = CALayer()          //上面的图片
    let bottomLayer = CALayer()       //下面的图片
    let gradLayer = CAGradientLayer()  // 阴影视图
    
    var delegate: SCFlipViewDelegate?   //设置代理
    var width:CGFloat {
        return self.bounds.width
    }
    var height:CGFloat {
        return self.bounds.height
    }
    
    init(imageKey: String, frame: CGRect) {
        self.imageKey = imageKey
        self.image = UIImage(named: imageKey)!
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
        
        gradLayer.frame = CGRectMake(0, height / 2, width, height / 2)
        gradLayer.colors = [UIColor.lightGrayColor().CGColor, UIColor.lightGrayColor().colorWithAlphaComponent(0.3).CGColor, UIColor.whiteColor().CGColor]
        gradLayer.opacity = 0.0
        
        self.layer.addSublayer(topLayer)
        self.layer.addSublayer(bottomLayer)
        self.layer.addSublayer(gradLayer)
    }
    
    func initLayer(layer: CALayer) {
        layer.shouldRasterize = true
        layer.contents = image.CGImage
    }
    
    func flip() {
        let angle = CGFloat(M_PI)
        var trans = CATransform3DMakeRotation(angle, 1.0, 0, 0)
        trans.m34 = -1 / 500.0
        
        let baseAnimation = CABasicAnimation()
        baseAnimation.duration = 1.0
//        baseAnimation.repeatCount = HUGE
        baseAnimation.delegate = self
        baseAnimation.keyPath = "transform"
        baseAnimation.toValue = NSValue.init(CATransform3D: trans)
        
        topLayer.addAnimation(baseAnimation, forKey: "Flip")
        
        let gradAnimation = CABasicAnimation()
        gradAnimation.duration = 1.0
//        gradAnimation.repeatCount = HUGE
        gradAnimation.keyPath = "opacity"
        gradAnimation.toValue = CGFloat(1.0)
        
        gradLayer.addAnimation(gradAnimation, forKey: "OPACITY")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        let index = imageKey.substringToIndex(imageKey.startIndex.advancedBy(2))
        self.delegate?.flipViewanimationDidStop(self, index: Int(index)!)
        
    }
}


protocol SCFlipViewDelegate {
    func flipViewanimationDidStop (flipView: SCFlipView, index: Int)
}










