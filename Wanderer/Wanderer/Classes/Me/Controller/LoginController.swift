//
//  LoginController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/17.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginController: UIViewController {

    @IBOutlet weak var headerBGView: UIView!
  
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var accountText: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var footerBGView: UIView!
    @IBAction func login(sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func weixinLogin() {
        let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToQQ)
        
        
        snsPlatform.loginClickHandler(self, UMSocialControllerService.defaultControllerService(), true, {
            (response) -> ()
            in
            
            if response.responseCode == UMSResponseCodeSuccess {
                
                let snsAccount = UMSocialAccountManager.socialAccountDictionary()[UMShareToQQ] as! UMSocialAccountEntity
                
                SVProgressHUD.setDefaultMaskType(.Black)
                SVProgressHUD.showSuccessWithStatus("登陆成功")
                NSNotificationCenter.defaultCenter().postNotificationName(kLogin, object: ["name" : snsAccount.userName, "url" : snsAccount.iconURL])
                self.back()
//                print(snsAccount.userName, snsAccount.accessToken, snsAccount.usid, snsAccount.iconURL)
                
                
            }
            
            
        })
    }
    @IBAction func weiboLogin() {
        let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina)
        snsPlatform.loginClickHandler(self, UMSocialControllerService.defaultControllerService(), true, {
            (response) -> ()
            in
            
            if response.responseCode == UMSResponseCodeSuccess {
                
                let snsAccount = UMSocialAccountManager.socialAccountDictionary()[UMShareToQQ] as! UMSocialAccountEntity
                
//                print(snsAccount.userName, snsAccount.accessToken, snsAccount.usid, snsAccount.iconURL)
                
                
            }
            
            
        })
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if accountText.editing == true || passwordText.editing == true {
            self.view.endEditing(true)
        }
    }

}

extension LoginController {
    func setupUI() {
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginController.keyboardChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    func keyboardChangeFrame(note : NSNotification) {
        
        if let info = note.userInfo as? [String : AnyObject] {
            guard let endframe = (info["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.CGRectValue() else {return}
            guard let startFrame = (info["UIKeyboardFrameBeginUserInfoKey"] as? NSValue)?.CGRectValue() else {return}
            guard let duration = info["UIKeyboardAnimationDurationUserInfoKey"] as? NSTimeInterval else {return}
            
            UIView.animateWithDuration(duration) {
                let deltaY = endframe.origin.y - startFrame.origin.y
                
                
                if deltaY < 0 {
                    self.headerBGView.alpha = 0.0
                    self.footerBGView.y -= 170
                } else {
                    self.headerBGView.alpha = 1.0
                    self.footerBGView.y += 170
                }
            }

        }
    }
    
    
}

extension LoginController : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
}
