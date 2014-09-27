//
//  ViewController.swift
//  SlideToCount
//
//  Created by Jerry Huang on 2014/9/27.
//  Copyright (c) 2014年 Jerry Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    let countLabel: UILabel = UILabel()
    var currentNum: Float = 0
    let speedMax: Float = 8000 // No need to change this (maybe)
    let countNumMax: Float = 50 // Change this to set the max value
    var const: Float = 50 // Change this to adjust your need
    
    struct viewSize {
        var width: CGFloat
        var height: CGFloat
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        var velocity: CGPoint = recognizer.velocityInView(self.view)
//        println("x,y: \(velocity.x), \(velocity.y)")
        
        // Set speed range = -speedMax ~ +speedMax
        switch (true) {
        case(Float(velocity.y) < -speedMax):
            velocity.y = -CGFloat(speedMax)
            break
        case(Float(velocity.y) > speedMax):
            velocity.y = CGFloat(speedMax)
            break
        default: break
        }
        
        // *** The most important variable
        var increaseNum: Float = Float(velocity.y)/speedMax/(Float(countNumMax)/const) * Float(countNumMax)
        
        println(increaseNum)
        currentNum -= increaseNum
        
        switch(true) {
        case (currentNum > countNumMax):
            currentNum = countNumMax
            break
        case (currentNum < 0):
            currentNum = 0
            break
        default: break
        }
        countLabel.text = "\(Int(currentNum))"
    }
    
    func initUI() {
        // Set UIPanGestureRecognizer
        let panRec = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
        panRec.delegate = self
        view.addGestureRecognizer(panRec)
        
        // Set screen resolution
        var screenResolution = viewSize(
            width: UIScreen.mainScreen().bounds.width,
            height: UIScreen.mainScreen().bounds.height)
        
        // Set label size
        var labelSize = viewSize(
            width: 75, height: 75)
        
        // Set label
        countLabel.frame = CGRectMake(
            screenResolution.width/2 - labelSize.width/2,
            screenResolution.height * 0.1,
            labelSize.width,
            labelSize.height)
        
        countLabel.text = "\(Int(currentNum))"
        countLabel.textColor = UIColor.blackColor()
        countLabel.layer.cornerRadius = labelSize.width/2
        countLabel.layer.borderWidth = 1
        countLabel.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(countLabel)
    }
}

