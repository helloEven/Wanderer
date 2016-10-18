//
//  ShareViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/15.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SVProgressHUD

class ShareViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bgImageView: UIImageView!
    var model : DestinationModel?
    var image : UIImage?
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    @IBAction func shareMore() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        ac.addAction(UIAlertAction(title: "分享到QQ", style: .Default, handler: { (ac) in
            UMSocialSnsService.presentSnsIconSheetView(self, appKey: nil, shareText: self.model?.topic, shareImage: self.image, shareToSnsNames: [UMShareToQQ], delegate: nil)
        }))
        ac.addAction(UIAlertAction(title: "下载到相册", style: .Default, handler: { (ac) in
             UIImageWriteToSavedPhotosAlbum(self.image!, nil, nil, nil)
        }))
        ac.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: { (ac) in
            
        }))
        
        self.presentViewController(ac, animated: true, completion: nil)
    }

    @IBAction func shareToWeibo(sender: AnyObject) {
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: nil, shareText: self.model?.topic, shareImage: self.image, shareToSnsNames: [UMShareToSina], delegate: self)
    }
    @IBAction func shareToFriendCircle(sender: AnyObject) {
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: nil, shareText: self.model?.topic, shareImage: self.image, shareToSnsNames: [UMShareToWechatTimeline], delegate: self)
    }
    @IBAction func shareToFriends() {
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: nil, shareText: self.model?.topic, shareImage: self.image, shareToSnsNames: [UMShareToWechatSession], delegate: self)
    }
    
    

}

extension ShareViewController: UMSocialUIDelegate {
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        if response.responseCode == UMSResponseCodeSuccess {
            SVProgressHUD.showSuccessWithStatus("分享成功")
        }
    }
}

extension ShareViewController {
    
    func setupUI() {
        
        bgImageView.sd_setImageWithURL(NSURL(string: (model?.contents1[0].photo_url)!))
        
        let view = ShareView.getView()
        view.model = model
        view.frame = CGRectMake(20, 20, scrollView.width - 40, (model?.shareViewHeight)!)
        scrollView.contentSize = CGSizeMake(scrollView.width, (model?.shareViewHeight)! + 100)
        scrollView.addSubview(view)
        scrollView.showsVerticalScrollIndicator = false
        self.image = UIImage.getFullScreenImage(self.scrollView)
       
        
        
    }
    func popVC() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
