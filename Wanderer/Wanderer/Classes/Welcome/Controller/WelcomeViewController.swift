//
//  WelcomeViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/21.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import AVFoundation

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    lazy var timer : NSTimer = {
        let timer = NSTimer(timeInterval: 2.0, target: self, selector: #selector(WelcomeViewController.timeGo), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        return timer
    }()
    
    lazy var avPlayer : AVPlayer = {
        let url = NSBundle.mainBundle().URLForResource("movie.mp4", withExtension: nil)
        
        let avPlayer = AVPlayer(URL: url!)
        
        return avPlayer
        
    }()
    
    var avLayer : AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        timer.fire()
        
        view.bringSubviewToFront(bgView)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        avPlayer.play()
    }

    @IBAction func go() {
        avPlayer.pause()
        UIApplication.sharedApplication().keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }

}

// MARK:- selector事件
var j = 0
extension WelcomeViewController {
    
    
    func timeGo() {
        if j > 3 {
            j = 0
        }
        scrollView.setContentOffset(CGPointMake(CGFloat(j) * kScreenWidth, 0), animated: true)
        
         j += 1
    }
}

// MARK:- 设置UI
extension WelcomeViewController{
    func setupUI() {
        avLayer = AVPlayerLayer(player: avPlayer)
        
        view.layer.addSublayer(avLayer!)
        
        avLayer?.frame = view.bounds
        
        avLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        goBtn.layer.cornerRadius = 5
        goBtn.layer.masksToBounds = true
        
        
        scrollView.contentSize = CGSizeMake(4 * scrollView.width, scrollView.height)
        let textArray = ["外面的世界很精彩","外面的世界很无奈","世界那么大,就要去看看","因为,我是一个Wanderer"]
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        
        for i in 0 ..< 4 {
            let label = UILabel()
            label.frame = CGRectMake(CGFloat(i) * scrollView.width, 0, scrollView.width, scrollView.height)
            label.text = textArray[i]
            label.textAlignment = .Center
            label.font = UIFont.italicSystemFontOfSize(25)
            label.textColor = UIColor.whiteColor()
            scrollView.addSubview(label)
            
        }
        
        scrollView.delegate = self
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

// MARK:- 代理
extension WelcomeViewController :UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x / kScreenWidth
        pageControl.currentPage = Int(x)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x / kScreenWidth
        pageControl.currentPage = Int(x)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        timer.invalidate()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer = NSTimer(timeInterval: 2.0, target: self, selector: #selector(WelcomeViewController.timeGo), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        timer.fire()
    }
}
