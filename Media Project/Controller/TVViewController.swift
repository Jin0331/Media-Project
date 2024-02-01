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

class TVViewController: UIViewController{
    
    
    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    lazy var mainTableView = UITableView()
    
    var mainList : [TrendTV] = [] { // trend TV
        didSet {
            mainCollectionView.reloadData()
        }
    }
    var popularList : [TVSeriesLists] = [] {
        didSet {
            mainTableView.reloadData()
        }
    }
    var topRatedList : [TVSeriesLists] = [] {
        didSet {
            mainTableView.reloadData()
        }
    }
    
    var popularStart = 1 // pagination 변수
    var topRatedStart = 1 // pagination 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHirerachy()
        configureLayout()
        configureView()
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchTrend(api: .trend) { (item:TVTrendModel) in
                print(#function, "TV-trend")
                self.mainList = item.results
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
        
        print(MediaAPI.Trend.popular(page: 0).indexValue)
    }
    
    func configureHirerachy() {
        view.addSubview(mainCollectionView)
        view.addSubview(mainTableView)
    }
    
    func configureLayout() {
        mainCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(mainCollectionView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.identifier)
        
        mainCollectionView.backgroundColor = .clear
        mainCollectionView.isPagingEnabled = true
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 300
        mainTableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
    }
}

//MARK: - table View
extension TVViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaAPI.Trend.allCases.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
        
        cell.subCollectionView.delegate = self
        cell.subCollectionView.dataSource = self
        cell.subCollectionView.prefetchDataSource = self
        
        cell.subCollectionView.tag = indexPath.row
        
        cell.subCollectionView.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.identifier)
        cell.titleLabel.text = MediaAPI.Trend.allCases[indexPath.row + 1].textValue
        cell.subCollectionView.reloadData()
        
        return cell
    }
}

//MARK: -collection View
extension TVViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               
        if self.mainCollectionView == collectionView {
            return mainList.count
        } else if collectionView.tag == MediaAPI.Trend.popular(page: 0).indexValue {
            return popularList.count
        } else {
            return topRatedList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier, for: indexPath) as! CommonCollectionViewCell
        
        if self.mainCollectionView == collectionView {
            let item = mainList[indexPath.item]
            let url = URL(string: "\(MediaAPI.baseImageUrl)\(item.backdropPath)")
            
            cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
        } else {
            let item = collectionView.tag == MediaAPI.Trend.popular(page: 0).indexValue ? popularList[indexPath.item] : topRatedList[indexPath.item] // case가 2개기때문에 가능함. case가 늘어나면 switch 사용하면 될 듯
            
            let url = URL(string: "\(MediaAPI.baseImageUrl)\(item.backdropPath ?? "")")
            cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
        }
        
        return cell
    }
    
    func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}

//MARK: - collection View pagination
extension TVViewController : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        if self.mainCollectionView != collectionView {
            let currentCount = collectionView.tag == MediaAPI.Trend.popular(page: 0).indexValue ? popularList.count : topRatedList.count
            var start : Int
            
            for item in indexPaths {
                if currentCount - 5 == item.item && currentCount < 9000 { //TODO: - totalPage는 따로 구현해야됨... 일단 러프하게 값 줌
                    if collectionView.tag == MediaAPI.Trend.popular(page: 0).indexValue {
                        self.popularStart += 1
                    } else {
                        self.topRatedStart += 1
                    }
                    
                    start = collectionView.tag == MediaAPI.Trend.popular(page: 0).indexValue ? self.popularStart : self.topRatedStart
                    
                    let mediaTrendCase = collectionView.tag == MediaAPI.Trend.popular(page: 0).indexValue ? MediaAPI.Trend.popular(page: start) : MediaAPI.Trend.top_rated(page: start)
                    
      
                    MediaAPIManager.shared.fetchTrend(api: mediaTrendCase) { (item : TVSeriesListsModel) in
                        
                        collectionView.tag == MediaAPI.Trend.popular(page: 0).indexValue ? self.popularList.append(contentsOf: item.results) : self.topRatedList.append(contentsOf: item.results)
                    }
                }
            }
        }
    }
}

