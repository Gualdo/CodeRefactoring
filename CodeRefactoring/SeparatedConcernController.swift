//
//  SeparatedConcernController.swift
//  CodeRefactoring
//
//  Created by De La Cruz, Eduardo on 21/11/2018.
//  Copyright © 2018 De La Cruz, Eduardo. All rights reserved.
//

import UIKit

class SeparatedConcernController : UITableViewController {
    
    var isLoadingData = false
    let loaderView = UIActivityIndicatorView(style: .whiteLarge)
    var homeFeed: HomeFeed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performDataFetch()
    }
    
    fileprivate func performDataFetch() {
        putInLoadingState()
        fetchData { (homeFeed) in
            self.homeFeed = homeFeed
            self.putInFinishedLoadingState()
        }
    }
    
    fileprivate func putInLoadingState() {
        self.homeFeed = nil
        self.isLoadingData = true
        self.loaderView.startAnimating()
        self.tableView.reloadData()
    }
    
    fileprivate func putInFinishedLoadingState() {
        self.isLoadingData = false
        self.loaderView.stopAnimating()
        self.tableView.reloadData()
    }
    
    fileprivate func fetchData(completion: @escaping (HomeFeed) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/youtube/home_feed"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch home feed: ", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let homeFeed = try JSONDecoder().decode(HomeFeed.self, from: data)
                completion(homeFeed)
            } catch let jsonErr {
                print("Failed to serialize json: ", jsonErr)
            }
        }.resume()
    }
}
