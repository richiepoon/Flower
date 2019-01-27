//
//  InterfaceController.swift
//  Flower WatchKit Extension
//
//  Created by PLL on 1/26/19.
//  Copyright © 2019 PLL. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    var up = "red"
    var down = "blue"
    var right = "green"
    var left = "yellow"
    var current_image = "green"
    
    var timer = Timer()
    var timer_open = Timer()
    var timer_reset = Timer()
    
    var seconds = 30.0
    
    @IBOutlet var closed: WKInterfaceImage!
    
    @objc func counter(){
        print(seconds)
        closed.setAlpha(CGFloat(seconds/30.0))
        seconds -= 1
        if (seconds < 0)
            {timer.invalidate()}
    }
    
    @objc func counter_open(){
        closed.setAlpha(CGFloat(seconds/20.0))
        seconds += 1
        if (seconds > 20)
            {timer_open.invalidate()
                longPress.isEnabled = false
                SwipeUp.isEnabled = true
                SwipeDown.isEnabled = true
                SwipeRight.isEnabled = true
                SwipeLeft.isEnabled = true
        }
    }
    
    @objc func counter_reset(){
        print(seconds)
        closed.setAlpha(CGFloat(seconds/20.0))
        seconds += 1
        if (seconds >= 20){
            print("reset")
            timer_reset.invalidate()
            longPress.isEnabled = true
            SwipeUp.isEnabled = false
            SwipeDown.isEnabled = false
            SwipeRight.isEnabled = false
            SwipeLeft.isEnabled = false
            seconds = 30
        }
    }
    
    @IBOutlet var longPress: WKLongPressGestureRecognizer!
    @IBAction func longPressAction(_ gestureRecognizer: WKLongPressGestureRecognizer) {
        if gestureRecognizer.state == .began{
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector (InterfaceController.counter), userInfo: nil, repeats: true)
            //DispatchQueue.main.asyncAfter(1.0)
        }
        if gestureRecognizer.state == .ended{
            seconds = 0
            closed.setAlpha(0.0)
            randomize_color()
            timer_open = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector (InterfaceController.counter_open), userInfo: nil, repeats: true)
        }

    }
    
    @objc func reset(){
        closed.setImageNamed("lotus_closed")
        closed.setAlpha(0.0)
        seconds = 0
        timer_reset = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector (InterfaceController.counter_reset), userInfo: nil, repeats: true)
    }
    
    @objc func randomize_color(){
        let number = Int.random(in: 0 ..< 5)
        print(number)
        if (number == 1){
            current_image = "red"
            closed.setImageNamed("lotus_red")
        }
        else if (number == 2){
            current_image = "green"
            closed.setImageNamed("lotus_green")
        }
        else if (number == 3){
            current_image = "blue"
            closed.setImageNamed("lotus_blue")
        }
        else {
            current_image = "yellow"
            closed.setImageNamed("lotus_yellow")
        }
        print(current_image)
    }
    
    
    @IBOutlet var Tap: WKTapGestureRecognizer!
    @IBAction func TapAction(_ sender: Any) {
        reset()
        Tap.isEnabled = false
    }
    
    @IBOutlet var SwipeUp: WKSwipeGestureRecognizer!
    @IBOutlet var SwipeDown: WKSwipeGestureRecognizer!
    @IBOutlet var SwipeRight: WKSwipeGestureRecognizer!
    @IBOutlet var SwipeLeft: WKSwipeGestureRecognizer!
    
    
    @IBAction func SwipeRightAction(_ sender: Any) {
        if (current_image == right){
            WKInterfaceDevice.current().play(.success)
            reset()
        }
        else{
            WKInterfaceDevice.current().play(.failure)
        }
        
    }
    @IBAction func SwipeUpAction(_ sender: Any) {
        if (current_image == up){
            WKInterfaceDevice.current().play(.success)
            reset()
        }
        else{
            WKInterfaceDevice.current().play(.failure)
        }
    }
    @IBAction func SwipeDownAction(_ sender: Any) {
        if (current_image == down){
            WKInterfaceDevice.current().play(.success)
            reset()
        }
        else{
            WKInterfaceDevice.current().play(.failure)
        }
    }
    @IBAction func SwipeLeftAction(_ sender: Any) {
        if (current_image == left){
            WKInterfaceDevice.current().play(.success)
            reset()
        }
        else{
            WKInterfaceDevice.current().play(.failure)
        }
    }
}
