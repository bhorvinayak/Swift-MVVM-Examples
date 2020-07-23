//
//  NewsFeedViewModel.swift
//  MVVMNewsFeedApp
//
//  Created by Vinayak Bhor on 19/05/20.
//  Copyright © 2020 Vinayak Bhor. All rights reserved.
//

import UIKit
//Step 3:
 protocol NewsFeedDelegate{
    
    func reloadFeedData(success:Bool,feedModel:DataStruct.NewsList)
    
}
class NewsFeedViewModel: NSObject{
    
    var delegate: NewsFeedDelegate?
    var newsFeedModel: DataStruct.NewsList?
    var newsFeedDataArray = [DataStruct.HitsData]()
    
    func fetchNewsFeedAPI(pageNo:Int){
        
        let urlString:String = NBUrlConstants.CommonURL2 + NBUrlConstants.DateWiseSearch + NBUrlConstants.PageNo + "\(pageNo)"
        RequestManager().get(requestString: urlString){
            (success, object) -> () in
            DispatchQueue.main.async(execute: {
                self.mapToNewsFeedModel(response: object, success: success)
            })
        }

    }
    
    // Used to map API response to Wishlist Model
    // Param: status -> Bool
    //        response -> Data Wishlist API response data
    // Return : nil

    func mapToNewsFeedModel(response: Data?, success:Bool){
        
        guard let response = response else {return}
        do{
            
            self.newsFeedModel = try JSONDecoder().decode(DataStruct.NewsList.self, from: response)
            //print(self.newsFeedModel?.totalResults.count)
            delegate?.reloadFeedData(success: true,feedModel:self.newsFeedModel!)
            
        }catch let jsonError
        {
            print(jsonError)
            //delegate?.reloadFeedData(success: false, feedModel: )
        }
        
    }
    
    func getNewsFeedData() -> [DataStruct.HitsData]
    {
        newsFeedDataArray  = newsFeedDataArray+(self.newsFeedModel!.hits)
       return newsFeedDataArray
    }

    
}
