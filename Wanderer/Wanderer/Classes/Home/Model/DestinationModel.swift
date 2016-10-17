//
//  DestinationModel.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/22.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class DestinationModel: NSObject {
    var id : Int = 0
    var lat : NSNumber?
    var lng : NSNumber?
    var district_id : NSNumber?
    var name : String?
    var name_en : String?
    var photo_url : String?
    var days_count : Int = 0
    var title : String?
    var days1 : [DayMoodel] = [DayMoodel]()
    var summary : String?
    var topic : String?
    var user : UserModel?
    var alias_name : String?
    var contents1 : [ContentModel] = [ContentModel]()
    var inspiration_activities_count : Int = 0
    var des : String?
    var categories1 : [String] = [String]()
    var likes_count : Int = 0
    var comments_count : Int = 0
    var favorites_count : Int = 0
    var cellHeight : CGFloat = 0.0
    var shareViewHeight : CGFloat = 0.0
    var isFull : Bool = false
    var address : String?
    var wishes_count : Int = 0
    var near_photo_url : String?
    
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        if let daysDict = dict["days"] as? [[String : AnyObject]] {
            for dayDict in daysDict {
                let model = DayMoodel(dict: dayDict)
                days1.append(model)
            }
        }
        
        if let contentsDict = dict["contents"] as? [[String : AnyObject]] {
            for contentDcit in contentsDict {
                let model = ContentModel(dict: contentDcit)
                contents1.append(model)
            }
        }
        
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = UserModel(dict: userDict)
        }
        
        if let desc = dict["description"] as? String {
            des = desc
        }
        
        if let cateArray = dict["categories"] as? [[String : AnyObject]] {
            for dict in cateArray {
                if let CateName = dict["name"] as? String {
                    categories1.append(CateName)
                }
            }
        }
        
        if let districtsArray = dict["districts"] as? [[String : AnyObject]] {
            if  let locaName = districtsArray[0]["name"] as? String {
                name = locaName
            }
            
            if let lat1 = districtsArray[0]["lat"] as? NSNumber {
                lat = lat1
            }
            if let lng1 = districtsArray[0]["lng"] as? NSNumber {
                lng = lng1
            }
            
            
        }
        
        if let photoDict = dict["photo"] as? [String : AnyObject] {
            near_photo_url = photoDict["photo_url"] as? String
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override init() {
        super.init()
    }
    
}

class PointModel: NSObject {
    var address :String?
    var topic : String?
    var introduce : String?
    var visit_tip : String?
    var photo_url : String?
    var destination : DestinationModel?
    var poi : DestinationModel?
    var icon_type : Int = -1
    var cellHeight : CGFloat = 0.0
    
    init(dict : [String : AnyObject]) {
        super.init()
    
        if let activityDict = dict["inspiration_activity"] as? [String : AnyObject] {
            setValuesForKeysWithDictionary(activityDict)
            if let desDict = activityDict["destination"] as? [String : AnyObject] {
                destination = DestinationModel(dict: desDict)
            }
            
            if let photoDict = activityDict["photo"] as? [String :AnyObject] {
                let url = photoDict["photo_url"] as? String
                photo_url = url
            }
            
            if let poiDict = dict["poi"] as? [String : AnyObject] {
                poi = DestinationModel(dict: poiDict)
            }
        }
    
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override init() {
        super.init()
    }

}
class DayMoodel: NSObject {
    var desc : String?
    
    var headerHeight : CGFloat = 0.0
    
    var points1 : [PointModel] = [PointModel]()
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
        if  let des = dict["description"] as? String {
            desc = des
        }
        
        if let pointsDict = dict["points"] as? [[String : AnyObject]] {
            for pointDict in pointsDict {
                let model = PointModel(dict: pointDict)
                points1.append(model)
            }
        }
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override init() {
        super.init()
    }
    
}

class UserModel: NSObject {
    var id : Int = 0
    var name : String?
    var gender : Int = -1
    var photo_url : String?
    var followings_count : Int = -1
    var followers_count : Int = -1
    var header_photo_url : String?
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
        if let header_photoDict = dict["header_photo"] as? [String : AnyObject] {
            header_photo_url = header_photoDict["photo_url"] as? String
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override init() {
        super.init()
    }
}

class ContentModel: NSObject {
    var photo_url : String?
    var width : CGFloat = 0
    var height : CGFloat = 0
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override init() {
        super.init()
    }
}

class DestinationDetailModel: NSObject {
    var count : Int = 0
    var title : String?
    var type : String?
    var models1 : [DestinationModel] = [DestinationModel]()
    var button_text : String?
    var cellHeight : CGFloat = 0.0
    var topic : String?
    var desc : String?
    var inspirations1 : [RankListModel] = [RankListModel]()
    var headerHeight : CGFloat = 0.0
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
        if let modelsDict = dict["models"] as? [[String : AnyObject]] {
            for modelDict in modelsDict {
                let model = DestinationModel(dict: modelDict)
                models1.append(model)
            }
        }
        
        if let inspirationsDict = dict["inspirations"] as? [[String : AnyObject]] {
            for inspirationDict in inspirationsDict {
                let rankListModel = RankListModel(dict: inspirationDict)
                inspirations1.append(rankListModel)
            }
        }
        
        if let des = dict["description"] as? String {
            desc = des
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override init() {
        super.init()
    }

}

class RankListModel: NSObject {
    var icon_type : Int = -1
    var wishes_count : Int = 0
    var visit_tip : String?
    var topic : String?
    var introduce : String?
    var photo_url : String?
    var cellHeight : CGFloat = 0.0
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
        if let photoDict = dict["photo"] as? [String : AnyObject] {
            photo_url = photoDict["photo_url"] as? String
        }
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override init() {
        super.init()
    }
}



