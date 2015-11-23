//
//  ViewController.swift
//  SCFlipClock
//
//  Created by ZhangSC on 15/11/20.
//  Copyright © 2015年 FYTech. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, SCFlipViewDelegate {

    var flip: SCFlipView?
    var disLink: CADisplayLink?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let flipView = SCFlipView.init(imageKey: "01.jpg", frame: CGRectMake(0, 0, 200, 200))
        flipView.center = self.view.center
        flipView.delegate = self
        flip = flipView
        self.view.addSubview(flipView)
        
        let button = UIButton.init(frame: CGRectMake(0, 0, 50, 50))
        button.addTarget(self, action: Selector("click:"), forControlEvents:.TouchUpInside)
        button.backgroundColor = UIColor.blueColor()
        self.view.addSubview(button)
        
        disLink = CADisplayLink.init(target: self, selector: Selector("startClock"))
        disLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        disLink?.paused = true
    }
    
    func click(sender: UIButton) {
        print("flip == \(flip)")
        flip?.flip()
    }
    
    func flipViewanimationDidStop(flipView: SCFlipView, index: Int) {
        print("flipViwe animation stop \(index)")
        flipView.removeFromSuperview()
        flip = nil
        addFlipView()
    }
    
    func startClock() {
        
    }
    
    func addFlipView() {
        let flipView = SCFlipView.init(imageKey: "01.jpg", frame: CGRectMake(0, 0, 200, 200))
        flipView.center = self.view.center
        flipView.delegate = self
        flipView.flip()
        self.view.addSubview(flipView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

