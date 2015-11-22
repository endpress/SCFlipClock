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
    let disLink: CADisplayLink = CADisplayLink()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let flipView = SCFlipView.init(imageKey: "01.jpg", frame: CGRectMake(0, 0, 200, 200))
        flipView.center = self.view.center
        flipView.delegate = self
        self.view.addSubview(flipView)
        flip = flipView
        let button = UIButton.init(frame: CGRectMake(0, 0, 50, 50))
        button.addTarget(self, action: Selector("click:"), forControlEvents:.TouchUpInside)
        button.backgroundColor = UIColor.blueColor()
        self.view.addSubview(button)
        
    }
    
    func click(sender: UIButton) {
        flip!.flip()

    }
    
    func flipViewanimationDidStop(flipView: SCFlipView, index: Int) {
        print("flipViwe animation stop \(index)")
        flipView.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

