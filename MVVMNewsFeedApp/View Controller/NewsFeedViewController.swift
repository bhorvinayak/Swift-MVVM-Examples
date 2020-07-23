//
//  NewsFeedViewController.swift
//  MVVMNewsFeedApp
//
//  Created by Vinayak Bhor on 19/05/20.
//  Copyright © 2020 Vinayak Bhor. All rights reserved.
//

import UIKit
//step 4
class NewsFeedViewController: UIViewController {
    
    let newsFeedViewModel:NewsFeedViewModel = NewsFeedViewModel()
    var dataArray:[DataStruct.HitsData] = []
    var indexValue:Int = 0
    var pageNumber: Int = 0
    var isFlag = true
    
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        newsFeedViewModel.delegate = self
        pageNumber = pageNumber+1
        newsFeedTableView.delegate = self
        newsFeedTableView.dataSource = self
        newsFeedTableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        newsFeedTableView.rowHeight = UITableView.automaticDimension
        newsFeedTableView.estimatedRowHeight = 44
        fetchMovie()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           self.navigationItem.title = "News"
       }

    override func viewWillDisappear(_ animated: Bool) {
           self.navigationItem.title = ""
       }

    func fetchMovie(){
        newsFeedViewModel.fetchNewsFeedAPI(pageNo:1)
    }

}
extension NewsFeedViewController: NewsFeedDelegate {
    func reloadFeedData(success: Bool, feedModel: DataStruct.NewsList) {
         if !success {
                   
               }else{
                   // reload list table
                   dataArray = feedModel.hits
                    newsFeedTableView.reloadData()
                   
               }
    }
    
    

}

