//
//  TVDetailViewController.swift
//  Media Project
//
//  Created by JinwooLee on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher


class TVDetailViewController: UIViewController {
    
    let mainView = TVDetailView()
    //MARK: - Data
    var tvSeriesId = 96102 //TODO: - Search TV API로 값 전달 받으면 됨
    var detailList : TVSeriesDetail?
    var recommendationsList : TVSeriesRecommendations?
    var aggregateCreditList : TVSeriesAggregateCredit?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchTV(api: .detail(id: self.tvSeriesId)) { (item : TVSeriesDetail ) in
                
                self.detailList = item
                group.leave()
            }

        }
        
        group.notify(queue: .main) {
            print("갱신완료")
            
            self.mainView.configureView(detailList: self.detailList)
        }
    }
    
    
}

extension TVDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recommendationsList?.results.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print(#function)
        
        guard let recommendationsList = recommendationsList else {
            print("fail")
            return UICollectionViewCell()}
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier, for: indexPath) as! CommonCollectionViewCell
        
        let item = recommendationsList.results[indexPath.item]
        let url = URL(string: MediaAPI.baseImageUrl + item.posterPath)!
        cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
        
        return cell
    }
}
