//
//  RankListCollectionView.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/28.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class RankListCollectionView: UICollectionView {

    var model : DestinationDetailModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource = self
        delegate = self
        registerNib(UINib(nibName: "RankListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "rankCell")
        
    }
}

extension RankListCollectionView : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (model?.models1.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("rankCell", forIndexPath: indexPath) as? RankListCollectionViewCell
            cell!.model = model?.models1[indexPath.row]
            return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let ID = model?.models1[indexPath.row].id
        let title = model?.models1[indexPath.row].title
        
        let array: [AnyObject] = [ID!,title!]
        NSNotificationCenter.defaultCenter().postNotificationName(kRankListCollectionViewCellClick, object: array)
    }
}
