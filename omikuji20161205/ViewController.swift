//
//  ViewController.swift
//  omikuji20161205
//
//  Created by 田中潤 on 2016/12/04.
//  Copyright © 2016年 田中潤. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var stickView: UIView!
    @IBOutlet weak var stickLabel: UILabel!
    @IBOutlet weak var stickHeight: NSLayoutConstraint!
    
    @IBOutlet weak var stickBottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var bigLabel: UILabel!
    let resultTexts: [String] = [
        "大吉",
        "中吉",
        "小吉",
        "吉",
        "末吉",
        "凶",
        "大凶"
    ]
    //大吉が出た時の音再生の再生オブジェクトを格納
    var daikichiAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    
    func setupSound(_ soundTitle:String) {
        
        //iPhoneを振った時の音の再生設定
        if let sound = Bundle.main.path(forResource: soundTitle, ofType: ".mp3") {
            daikichiAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            daikichiAudioPlayer.prepareToPlay()
        }
    }
    
    
    
    
    
    override func motionEnded (_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if motion != UIEventSubtype.motionShake  || overView.isHidden == false {
            //シェイクモーション以外では動作させない
            return
        }
        
        let resultNum = Int( arc4random_uniform(UInt32(resultTexts.count)))
        stickLabel.text = resultTexts[resultNum]
        stickBottomMargin.constant = stickHeight.constant * -1
        
        switch resultNum {
        case 0 : //大吉の時
            
            //音の準備
            setupSound("lucky")
            daikichiAudioPlayer.play()
            
        case 1: //中吉の時
            setupSound("chukichi")
            daikichiAudioPlayer.play()
        case 2: //小吉の時
            setupSound("shokichi")
            daikichiAudioPlayer.play()
        case 3: //吉の時
            setupSound("kichi")
            daikichiAudioPlayer.play()
        case 4: //末吉の時
            setupSound("suekichi")
            daikichiAudioPlayer.play()
        case 5: //凶の時
            setupSound("kyo")
            daikichiAudioPlayer.play()
            
        default :
            setupSound("down")
            daikichiAudioPlayer.play()
            break
        }
        
        UIView.animate(withDuration :5, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: { (finished: Bool) in
            self.bigLabel.text = self.stickLabel.text
            self.overView.isHidden = false
        })
        
    }
    
    @IBAction func tapRetryButton(_ sender: UIButton) {
        overView.isHidden = true
        stickBottomMargin.constant = 0
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //音の準備
        setupSound("")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

