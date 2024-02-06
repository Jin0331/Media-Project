//
//  TVDetailViewController.swift
//  Media Project
//
//  Created by JinwooLee on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher


class CommonCollectionViewController: BaseViewController {
    
    let mainView = CommonCollcionView()
    
    //MARK: -데이터 목록
    var dataList : TVSeriesRecommendations? //MARK: - Discover API를 통해 데이터가 들어옴
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        mainView.mainCollectionView.delegate = self
        mainView.mainCollectionView.dataSource = self
        
        let group = DispatchGroup()
        
        //MARK: - Configuration API request\
        //TODO: - 💄 Detail 또는 Discover로 값 호출해야 됨
        
        // genre
        group.enter()
        DispatchQueue.global().async(group: group) {
            print(self.genreID)
            MediaSessionManager.shared.fetchURLSession(api: MediaAPI.SearchDetail.genere(id: self.genreID)) { (item : TVSeriesRecommendations?, error : MediaAPI.APIError?) in
                if error == nil {
                    if self.genreID != 0 {
                        guard let item = item else { return }
                        self.dataList = item
                        print("여기 실행됨???????", #function)
                    }
                } else {
                    dump(error)
                }
                group.leave()
            }
        }
        
        // country
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaSessionManager.shared.fetchURLSession(api: MediaAPI.SearchDetail.countries(id: self.countryID)) { (item : TVSeriesRecommendations?, error : MediaAPI.APIError?) in
                if error == nil {
                    if self.countryID != "" {
                        guard let item = item else { return }
                        self.dataList = item
                    }
                } else {
                    dump(error)
                }
                group.leave()
            }
        }
        
//        // detail
//        group.enter()
//        DispatchQueue.global().async(group: group) {
//            MediaSessionManager.shared.fetchURLSession(api: MediaAPI.SearchDetail.genere(id: self.genreID)) { (item : TVSeriesRecommendations?, error : MediaAPI.APIError?) in
//                if error == nil {
//                    guard let item = item else { return }
//                    self.genereList = item
//
//                } else {
//                    dump(error)
//                }
//                group.leave()
//            }
//        }
//
        group.notify(queue: .main) {
            print(#function, " - 갱신완료")
            dump(self.dataList)
            self.mainView.mainCollectionView.reloadData()
        }
    }
    
}

extension CommonCollectionViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let data = dataList else { return 1 }
        
        return data.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier, for: indexPath) as! CommonCollectionViewCell
        
        if let dataList {
            let item = dataList.results[indexPath.item]
            
            let url = URL(string: MediaAPI.baseImageUrl + item.posterPath)!
            cell.posterImageView.kf.setImage(with: url, options: [.transition(.fade(1))])
        }

        return cell
    }
}
