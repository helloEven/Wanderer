//
//  ShowAllPictureViewController.swift
//  Wanderer
//
//  Created by 刘杰 on 16/10/14.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class ShowAllPictureViewController: UIViewController {
    
    var index : Int = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var model : DestinationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }
    
    
}

extension ShowAllPictureViewController {
    func setupUI() {
        pageControl.numberOfPages = (model?.contents1.count)!
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(kScreenWidth, 200)
        layout.minimumLineSpacing = 20
//        layout.minimumInteritemSpacing = 20
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        
        collectionView.registerNib(UINib(nibName: "PicttureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "picCell")
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ShowAllPictureViewController.dismissView)))
        
        
        collectionView.contentOffset = CGPointMake(CGFloat(index) * (kScreenWidth + 20), 0)
    }
    
        
    func dismissView() {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
}

extension ShowAllPictureViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (model?.contents1.count)!
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("picCell", forIndexPath: indexPath) as! PicttureCollectionViewCell
        cell.model = model?.contents1[indexPath.row].photo_url
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x / kScreenWidth
        pageControl.currentPage = Int(x)
    }

}
