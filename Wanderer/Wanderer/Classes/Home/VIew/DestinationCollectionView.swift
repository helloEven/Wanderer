//
//  DestinationCollectionView.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/26.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class DestinationCollectionView: UICollectionView {

    var dataArray : [DestinationModel]  = [DestinationModel](){
        didSet {
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource = self
        delegate = self
        //destinationCell
        registerNib(UINib(nibName: "DestinationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "destinationCell")
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(120, 180)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        self.showsHorizontalScrollIndicator = false
    }

}

extension DestinationCollectionView : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("destinationCell", forIndexPath: indexPath) as! DestinationCollectionViewCell
            
            
            cell.model = self.dataArray[indexPath.row]
            
            return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let model = dataArray[indexPath.row]
        NSNotificationCenter.defaultCenter().postNotificationName(kNearDestinationCollectionViewCellClick, object: model)
    }
    
}
