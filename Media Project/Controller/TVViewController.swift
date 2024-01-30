//
//  ViewController.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

//MARK: - TrendTV는 page 없이 20개의 결과로 제한 됨. 따라서, 상단의 Collection View로 사용
//MARK: - Top Rated와 Popularity는 Page가 있으므로, 하단에서 pagination 적용되어야 함. 아니면 갯수제한?

import UIKit

class TVViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // TV trend
//        MediaAPIManager.shared.fetchTrendingTV { tv in
//            print(#function, "TV-trend ", tv)
//        }
        
        // popular
        MediaAPIManager.shared.fetchTVSeriesLists(contents: MediaAPIManager.TVSeries.popular.rawValue, page: 1) { tv in
            print(#function, "Popular ", tv)
        }

        // top rate
//        MediaAPIManager.shared.fetchTVSeriesLists(contents: MediaAPIManager.TVSeries.top_rated.rawValue, page: 1) { tv in
//            print(#function, "Top Rate ", tv)
//        }
        
    }


}

