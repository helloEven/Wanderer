//
//  AppDelegate.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/20.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
 

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.rootViewController = WelcomeViewController()
        window?.makeKeyAndVisible()
        
        UITabBar.appearance().tintColor = kGlobelColor
        
        // 友盟基础SDK授权
        UMSocialData.setAppKey("580270c467e58e6bd3004726")
        
        // 设置没有安装的APP , 隐藏对应的平台
        UMSocialConfig.hiddenNotInstallPlatforms([UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline, UMShareToWechatFavorite,UMShareToSina])
        
        // 微信
        UMSocialWechatHandler.setWXAppId("wxdc1e388c3822c80b", appSecret: "3baf1193c85774b3fd9d18447d76cab0", url: "http://www.umeng.com/social")
        
        // 新浪微博
        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("3921700954", secret: "04b48b094faeb16683c32669824ebdad", redirectURL: "http://sns.whalecloud.com/sina2/callback")
        
        
        // QQ
        UMSocialQQHandler.setQQWithAppId("100424468", appKey: nil, url: "http://mobile.umeng.com/social")
        
        
        return true
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        // wxd930ea5d5a258f4f
        
        
        let result = UMSocialSnsService.handleOpenURL(url)
        if result == false {
            //调用其他SDK，例如支付宝SDK等
        }
        return result;
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        let result = UMSocialSnsService.handleOpenURL(url)
        if result == false {
            //调用其他SDK，例如支付宝SDK等
        }
        return result;
    }



}

