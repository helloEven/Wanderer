//
//  AudioTool.swift
//  二. 音效播放
//
//  Created by xiaomage on 16/4/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit
import AVFoundation

class AudioTool: NSObject {

    class func playAudio(audioName: String, isAlert: Bool, completion: ()->()) {
    
    // 1. 获取音效文件对应的soundid
    guard let url = NSBundle.mainBundle().URLForResource(audioName, withExtension: nil) else { return }
    let urlCF = url as CFURLRef
    
    // 1.1 创建  SystemSoundID
    var soundID: SystemSoundID = 0
    AudioServicesCreateSystemSoundID(urlCF, &soundID)
    
    
        if isAlert {
            AudioServicesPlayAlertSoundWithCompletion(soundID, { 
                
                // 1. 释放资源
                AudioServicesDisposeSystemSoundID(soundID)
                
                // 2. 告诉外界播放完成的事件
                completion()
                
            })
        }else {
            AudioServicesPlaySystemSoundWithCompletion(soundID, { 
                // 1. 释放资源
                AudioServicesDisposeSystemSoundID(soundID)
                
                // 2. 告诉外界播放完成的事件
                completion()
            })
        }
        


    }
    
    
}
