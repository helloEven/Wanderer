//
//  UserActivityCell.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/15.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
import SDWebImage
class UserActivityCell: UITableViewCell {


    @IBOutlet weak var favariteBtn: UIButton!
    @IBOutlet weak var commentBrn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var categoryLabel: UICollectionView!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var smallCollectionView: UICollectionView!
    @IBOutlet weak var bigImageView: UIImageView!

    @IBOutlet weak var bigImageViewTopCons: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var gapView: UIView!
    var model : DestinationModel? {
        didSet{
            
            if model?.isFull == false {
                bigImageViewTopCons.constant = 0
                headerView.hidden = true
            } else {
                bigImageViewTopCons.constant = 44
                headerView.hidden = false
                iconView.sd_setImageWithURL(NSURL(string: (model?.user?.photo_url)!))
                nameLabel.text = model?.user?.name
                
            }
            
            
            
            favariteBtn.setTitle("\((model?.favorites_count)!)", forState: .Normal)
            commentBrn.setTitle("\((model?.comments_count)!)", forState: .Normal)
            likeBtn.setTitle("\((model?.likes_count)!)", forState: .Normal)
            desLabel.text = model?.des
            topicLabel.text = model?.topic
            bigImageView.sd_setImageWithURL(NSURL(string: (model?.contents1[0].photo_url)!))
            
            let layout1 = smallCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout1.itemSize = CGSizeMake(155, 90)
            layout1.minimumLineSpacing = 5
            layout1.minimumInteritemSpacing = 5
            
            let layout2 = categoryLabel.collectionViewLayout as! UICollectionViewFlowLayout
            layout2.itemSize = CGSizeMake(80, 30)
            layout2.minimumLineSpacing = 5
            layout2.minimumInteritemSpacing = 15
            
            if model?.cellHeight == 0.0 {
                layoutIfNeeded()
                model?.cellHeight = CGRectGetMaxY(gapView.frame)
            }
            
            
            smallCollectionView.reloadData()
            categoryLabel.reloadData()
        }
    }
    
 

    @IBAction func favarite(sender: UIButton) {
        let vc = LoginController()
        self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
    }
    @IBAction func comment(sender: UIButton) {
        let vc = LoginController()
        self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
    }
    @IBAction func like(sender: UIButton) {
        let vc = LoginController()
        self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
    }
    @IBAction func showMore(sender: UIButton) {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        ac.addAction(UIAlertAction(title: "分享", style: .Default, handler: { (hander) in
            let vc = ShareViewController()
            vc.model = self.model
            self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
        }))
        ac.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: { (hander) in
            
        }))
        
        self.window?.rootViewController?.presentViewController(ac, animated: true, completion: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        smallCollectionView.dataSource = self
        smallCollectionView.delegate = self
        categoryLabel.dataSource = self
        categoryLabel.delegate = self
        
        iconView.layer.cornerRadius = 20
        iconView.layer.masksToBounds = true
        
        smallCollectionView.showsHorizontalScrollIndicator = false
        categoryLabel.showsHorizontalScrollIndicator = false
        
        bigImageView.userInteractionEnabled = true
        
        bigImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UserActivityCell.showAllPicture)))
        
        smallCollectionView.registerNib(UINib(nibName: "PicttureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "picCell")
        categoryLabel.registerNib(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cateCell")
    }
    
    class func getCellWithTableView(tableview : UITableView) ->UserActivityCell {
        var cell = tableview.dequeueReusableCellWithIdentifier("acCell") as? UserActivityCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("UserActivityCell", owner: nil, options: nil).last as? UserActivityCell
        }
        return cell!
        
        
    }
    func showAllPicture() {
        let vc = ShowAllPictureViewController()
        vc.model = model
        vc.index = 0
        vc.modalPresentationStyle = .OverCurrentContext
        self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
    }

}
extension UserActivityCell : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == smallCollectionView {
            return (model?.contents1.count)! - 1
        } else {
            return (model?.categories1.count)!
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == smallCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("picCell", forIndexPath: indexPath) as! PicttureCollectionViewCell
            cell.model1 = model?.contents1[indexPath.row + 1].photo_url
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cateCell", forIndexPath: indexPath) as! CategoryCollectionViewCell
            cell.model = model?.categories1[indexPath.row]
            return cell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == smallCollectionView {
            let vc = ShowAllPictureViewController()
            vc.model = model
            vc.index = indexPath.row + 1
            vc.modalPresentationStyle = .OverCurrentContext
            self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
        }
    }
}


