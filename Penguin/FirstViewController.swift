//
//  FirstViewController.swift
//  Penguin
//
//  Created by Shoki Lin on 2016/05/18.
//  Copyright © 2016年 Shoki Lin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet var kaisuulabel: UILabel!
    @IBOutlet var countdownlabel: UILabel!
    @IBOutlet var fishButtons: [UIButton]!
    var count: Float = 0.0
    var countdown: Int!
    // ペンギン画像を出す
    var timer: NSTimer = NSTimer()
    // 30秒測るタイマー
    var countDownTimer: NSTimer = NSTimer()
    //押した数を数える
    var kaisuu: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownlabel.text = String(countdown ?? 30)
        for i in 0 ..< fishButtons.count {
            fishButtons[i].enabled = false
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startbutton() {
        timer2()
        seigenzikan()
        
    }
    
    
    func timer2(){
        if !timer.valid {
            //タイマーが作動していなかったら動かす
            timer = NSTimer.scheduledTimerWithTimeInterval(0.001,
                target: self,
                selector: Selector("up"),
                userInfo: nil,
                repeats: true
            )
        }
    }
    func seigenzikan(){
        if !countDownTimer.valid {
            countdown = 30
            countdownlabel.text = String(countdown)
            //タイマーが作動していなかったら動かす
            countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1,
                target: self,
                selector: Selector("down"),
                userInfo: nil,
                repeats: true
                
            )
        }
    }
    
    func down() {
        countdown = countdown - 1
        countdownlabel.text = String(countdown)
        
        if countdown == 0 {
            timer.invalidate()
            countDownTimer.invalidate()
        }
        
    }
    
    
    func up() {
        //countを0.01(時間経過分)足す
        count = count + 0.01
        if countdown != 0 {
            
            if count >= 0.7 {
                //ボタンを押した時に乱数を発生させる
                let rannsuu = Int(rand()) % fishButtons.count
                
                let PenginRand = Int(rand()) % 3
                if PenginRand == 0{
                    fishButtons[rannsuu].setBackgroundImage(UIImage(named: "ペンギン.png"), forState: .Normal)
                }else if PenginRand == 1{
                    fishButtons[rannsuu].setBackgroundImage(UIImage(named: "ペンギン♀.png"), forState: .Normal)
                }else if PenginRand == 2{
                    fishButtons[rannsuu].setBackgroundImage(UIImage(named: "ヒナ.png"), forState: .Normal)
                }
                
                fishButtons[rannsuu].enabled = true
                timer.invalidate()
                count = 0
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.7
                    * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    if self.fishButtons[rannsuu].backgroundImageForState(.Normal) == UIImage(named: "ペンギン.png"){
                        self.fishButtons[rannsuu].setBackgroundImage(UIImage(named: "氷の穴.png"), forState: .Normal)
                        self.fishButtons[rannsuu].enabled = false
                        self.timer2()
                    }
                    if self.fishButtons[rannsuu].backgroundImageForState(.Normal) == UIImage(named: "ペンギン♀.png"){
                        self.fishButtons[rannsuu].setBackgroundImage(UIImage(named: "氷の穴.png"), forState: .Normal)
                        self.fishButtons[rannsuu].enabled = false
                        self.timer2()
                    }
                    if self.fishButtons[rannsuu].backgroundImageForState(.Normal) == UIImage(named: "ヒナ.png"){
                        self.fishButtons[rannsuu].setBackgroundImage(UIImage(named: "氷の穴.png"), forState: .Normal)
                        self.fishButtons[rannsuu].enabled = false
                        self.timer2()
                    }
                }
                
            }
        
        }
    }
    
    @IBAction func fishbutton(sender: UIButton) {
        print(sender.tag)
        //倒したペンギンの数を表示する
        if timer.valid {
            //タイマーが作動していたら停止する。
            timer.invalidate()
        }
        //赤ボタン押したら背景を白に戻す
        sender.enabled = false
        if (sender.backgroundImageForState(.Normal) == UIImage(named: "ペンギン.png")){
            sender.setBackgroundImage(UIImage(named: "氷の穴.png"), forState: .Normal)
            timer2()
            kaisuu = kaisuu + 1
        }
        if (sender.backgroundImageForState(.Normal) == UIImage(named: "ペンギン♀.png")){
            sender.setBackgroundImage(UIImage(named: "氷の穴.png"), forState: .Normal)
            timer2()
            kaisuu = kaisuu + 5
        }
        if (sender.backgroundImageForState(.Normal) == UIImage(named: "ヒナ.png")){
            
            sender.setBackgroundImage(UIImage(named: "氷の穴.png"), forState: .Normal)
            timer2()
            kaisuu = kaisuu + 2
        }
        kaisuulabel.text = String(kaisuu)
        print("button push")
    }
    @IBAction func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}