//
//  MovieCollectionFeedExtension.swift
//  MVVMNewsFeedApp
//
//  Created by Vinayak Bhor on 19/05/20.
//  Copyright © 2020 Vinayak Bhor. All rights reserved.
//

import Foundation
import Foundation
import UIKit
extension NewsFeedViewController : UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print("dataArray :\(dataArray.count)")
         return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTabTableViewCell
        cell.titleLbl.text = "\(indexPath.row). \(dataArray[indexPath.row].story_title ?? "NA")"
        return cell
    }
    
}
