//
//  NetWorkingTools.swift
//  weiBo
//
//  Created by ÂàòÊù∞ on 16/8/4.
//  Copyright ¬© 2016Âπ¥ even. All rights reserved.
//

import UIKit
import AFNetworking

enum MethodType : String {
    case GET = "GET"
    case POST = "POST"
}

class NetWorkingTools: AFHTTPSessionManager {
    
    static let sharedInstance : NetWorkingTools = {
        
        let  tool = NetWorkingTools()
        
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
    
        return tool
    }()
    
}

// MARK:- 请求方法
extension  NetWorkingTools {
    
    func request(method : MethodType, urlString : String , parameters : [String : AnyObject]? , finished:(result : AnyObject? , error : NSError?) -> ()) {
        
        let successCallBack = { (task : NSURLSessionTask, result : AnyObject?) -> Void in
            
            finished(result: result, error: nil)
        }
        
        let failCallBack = { (task : NSURLSessionDataTask?, error : NSError) -> Void in
            
            finished(result: nil, error: error)
        }
        
        
        if method == .GET {
            GET(urlString, parameters: parameters, progress: nil, success: successCallBack, failure:failCallBack)
        }
        
        if method == .POST {
            POST(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failCallBack)
        }
    }
}

// MARK:- 请求数据
extension NetWorkingTools {
    // 请求滚动视图的数据
    func requestHomeScrollViewData(finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v1/adverts.json"
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: nil) { (result, error) in
            guard let resultDict = result!["data"] as? [[String : AnyObject]] else {
                finished(result:nil , error: error)
                return
            }
            
            finished(result: resultDict, error: nil)
        }
    }
    
    // 请求大陆热门目的地
    func requestChinaHotDestinationData(finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v2/destinations/list.json"
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: ["area" : "china"]) { (result, error) in
            
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
            finished(result: resultDict["data"] as? [[String : AnyObject]], error: nil)
        }
    
    }
    
    //  请求亚洲热门数据
    func requestAisianHotDestinationData(finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v2/destinations/list.json"
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: ["area":"asia"]) { (result, error) in
            
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            finished(result: resultDict["data"] as? [[String : AnyObject]], error: nil)
        }
    }
    
    // 请求港澳台数据
    func requestTWAMXGData(finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v2/destinations.json"
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: nil) { (result, error) in
            
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
           finished(result: resultDict["data"]![1]["destinations"] as? [[String : AnyObject]], error: nil)
        }
        
    }
    
    // 请求欧洲数据
    func requestEuropeHotDestinationData(finished: (result : [[String : AnyObject]]?, error : NSError?) -> ())  {
        let urlString = "http://q.chanyouji.com/api/v2/destinations/list.json"
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: ["area":"europe"]) { (result, error) in
            
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            finished(result: resultDict["data"] as? [[String : AnyObject]], error: nil)
        }
    
    }
    
    // 请求其他目的地数据
    func requestOtherHotDestinationData(finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v2/destinations.json"
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: nil) { (result, error) in
            
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
          finished(result: resultDict["data"]![4]["destinations"] as? [[String : AnyObject]], error: nil)
        }
    }

    
   // 目的地详情数据
    func requestDestinationDetailData( id : String, finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v3/destinations/"
        
        let url = urlString + id
        
        NetWorkingTools.sharedInstance.request(.GET, urlString: url, parameters: nil) { (result, error) in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
            finished(result: resultDict["data"]!["sections"] as? [[String : AnyObject]], error: nil)
        }
    }
    
    // 榜单详情数据
    func requestRankListData(url : String, finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        NetWorkingTools.sharedInstance.request(.GET, urlString: url, parameters: nil) { (result, error) in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
            finished(result: resultDict["data"] as? [[String : AnyObject]], error: nil)
    }
  }
    // 请求榜单数据
    func requestRankListDetailData(idStr : String, finished: (result : [String : AnyObject]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v2/activity_collections/"
        
        let url = urlString + idStr
        
        NetWorkingTools.sharedInstance.request(.GET, urlString: url, parameters: nil) { (result, error) in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
            finished(result: resultDict["data"]! as? [String : AnyObject], error: nil)
        }
    }
    
    // 请求用户数据
    func requestUserInfoData(idStr : String, finished: (result : [String : AnyObject]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v1/users/" +  idStr + "/profiles.json"
        
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: nil) { (result, error) in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
            finished(result: resultDict["data"]! as? [String : AnyObject], error: nil)
        }
    }
    
    // 请求用户数据
    func requestUserActivityData(idStr : String, finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v1/users/" + idStr + "/user_activities.json?grouped=1"
        
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: nil) { (result, error) in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
            finished(result: resultDict["data"]! as? [[String : AnyObject]], error: nil)
        }
    }
    
    // 请求地方游记
    func requestUserAllActivityData(disID : Int ,page : Int, finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v1/user_activities.json?district_id=" + "\(disID)" + "&page=" + "\(page)"
        // ["district_id" : "\(disID)", "page" : "\(page)"]
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: nil) { (result, error) in
            
    
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
            finished(result: resultDict["data"]!["user_activities"] as? [[String : AnyObject]], error: nil)
        }
    }
    
    // 请求游记
    func requestAllAcitivities(page : Int ,finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v1/timelines.json?interests=&page=" + "\(page)" + "&per=50"
        
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: nil) { (result, error) in
            
            
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
            finished(result: resultDict["data"]! as? [[String : AnyObject]], error: nil)
        }
    }
    // 请求附近目的地数据
    func requestNearbyData(lat : Double , lng : Double,finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v2/destinations/nearby.json?lat="+"\(lat)" + "&lng=" + "\(lng)"
        
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: nil) { (result, error) in
            
            
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
            finished(result: resultDict["data"]! as? [[String : AnyObject]], error: nil)
        }
    }
    
    // 请求附近灵感
    func requestNearbyAcitivitiesData(lat : Double , lng : Double,finished: (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "http://q.chanyouji.com/api/v2/destinations/nearby_inspiration_activities.json?lat="+"\(lat)" + "&lng=" + "\(lng)"
    
        NetWorkingTools.sharedInstance.request(.GET, urlString: urlString, parameters: nil) { (result, error) in
            
            
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
            finished(result: resultDict["data"]! as? [[String : AnyObject]], error: nil)
        }
    }

}