//
//  ViewController.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

//MARK: - TrendTV는 page 없이 20개의 결과로 제한 됨. 따라서, 상단의 Collection View로 사용
//MARK: - Top Rated와 Popularity는 Page가 있으므로, 하단에서 pagination 적용되어야 함. 아니면 갯수제한?
//MARK: - backdropPath 및 posterPath에서 nil 존재함

import UIKit
import SnapKit
import Kingfisher

class TVViewController: BaseViewController{
    
    let mainView = TVView()
    
    var mainList : TVTrendModel?
    var popularList : [TVSeriesLists] = []
    var topRatedList : [TVSeriesLists] = []
    
    var popularStart = 1 // pagination 변수
    var topRatedStart = 1 // pagination 변수
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchTrend(api: .trend) { (item:TVTrendModel) in
                print(#function, "TV-trend")
                self.mainList = item
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchTrend(api: .popular(page: self.popularStart)) { (item:TVSeriesListsModel) in
                print(#function, "TV-Popular")
                self.popularList = item.results
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchTrend(api: .top_rated(page: self.topRatedStart)) { (item:TVSeriesListsModel) in
                print(#function, "TV-Popular")
                self.topRatedList = item.results
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("조회 완료")
            self.mainView.mainTableView.reloadData()
        }
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        navigationItem.title = "홈"
    }
    
}

//MARK: - table View
extension TVViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaAPI.Trend.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  MediaAPI.Trend.trend.indexValue == indexPath.row ? 550 : 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if MediaAPI.Trend.trend.indexValue == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as! PosterTableViewCell
            cell.configureView(dataList: mainList)
            cell.titleLabel.text = MediaAPI.Trend.searchByIndex(value: indexPath.row).textValue
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
            
            cell.subCollectionView.delegate = self
            cell.subCollectionView.dataSource = self
            cell.subCollectionView.prefetchDataSource = self
            cell.subCollectionView.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.identifier)
            
            cell.subCollectionView.layer.name = MediaAPI.Trend.searchByIndex(value: indexPath.row).caseValue // collection cell의 layer name
            cell.titleLabel.text = MediaAPI.Trend.searchByIndex(value: indexPath.row).textValue
            cell.subCollectionView.reloadData()
            
            return cell
        }
    }
}

//MARK: -collection View
extension TVViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.layer.name! == MediaAPI.Trend.popular(page: 0).caseValue {
            return popularList.count
        } else {
            return topRatedList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier, for: indexPath) as! CommonCollectionViewCell
        
        let item = collectionView.layer.name! == MediaAPI.Trend.popular(page: 0).caseValue ? popularList[indexPath.item] : topRatedList[indexPath.item] // case가 2개기때문에 가능함. case가 늘어나면 switch 사용하면 될 듯
        
        let url = URL(string: "\(MediaAPI.baseImageUrl)\(item.posterPath ?? "")")
        cell.posterImageView.kf.setImage(with: url, options: [.transition(.fade(1))])
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = collectionView.layer.name! == MediaAPI.Trend.popular(page: 0).caseValue ? popularList[indexPath.item] : topRatedList[indexPath.item]
        tvViewTransition(style: .push, viewController: TVDetailViewController.self, tvID: item.id)
    }
    
}

//MARK: - collection View pagination
extension TVViewController : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        print(#function, collectionView.layer.name!)
        
        let currentCount = collectionView.layer.name! == MediaAPI.Trend.popular(page: 0).caseValue ? popularList.count : topRatedList.count
        var start : Int
        
        for item in indexPaths {
            if currentCount - 5 == item.item && currentCount < 9000 { //TODO: - totalPage는 따로 구현해야됨... 일단 러프하게 값 줌
                if collectionView.layer.name! == MediaAPI.Trend.popular(page: 0).caseValue {
                    self.popularStart += 1
                } else {
                    self.topRatedStart += 1
                }
                
                start = collectionView.layer.name! == MediaAPI.Trend.popular(page: 0).caseValue ? self.popularStart : self.topRatedStart
                
                let mediaTrendCase = collectionView.layer.name! == MediaAPI.Trend.popular(page: 0).caseValue ? MediaAPI.Trend.popular(page: start) : MediaAPI.Trend.top_rated(page: start)
                
                
                MediaAPIManager.shared.fetchTrend(api: mediaTrendCase) { (item : TVSeriesListsModel) in
                    
                    collectionView.tag == MediaAPI.Trend.popular(page: 0).indexValue ? self.popularList.append(contentsOf: item.results) : self.topRatedList.append(contentsOf: item.results)
                }
            }
        }
        
    }
}

