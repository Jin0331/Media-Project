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

class TVViewController: UIViewController, ViewSetUp{

    
    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    lazy var mainTableView = UITableView()
    
    var mainList : [TrendTV] = [] {
        didSet {
            mainCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHirerachy()
        configureLayout()
        configureView()
        
        // TV trend
        MediaAPIManager.shared.fetchTrendingTV { tv in
            print(#function, "TV-trend")
            self.mainList = tv
            print(tv)
        }
        
//        // popular
//        MediaAPIManager.shared.fetchTVSeriesLists(contents: MediaAPIManager.TVSeries.popular.rawValue, page: 1) { tv in
//            print(#function, "Popular ", tv)
//        }
//
//        // top rate
//        MediaAPIManager.shared.fetchTVSeriesLists(contents: MediaAPIManager.TVSeries.top_rated.rawValue, page: 1) { tv in
//            print(#function, "Top Rate ", tv)
//        }
//        
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
        mainCollectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        
        mainCollectionView.backgroundColor = .clear
        mainCollectionView.isPagingEnabled = true
        
//        mainTableView.delegate = self
//        mainTableView.dataSource = self
//        mainTableView.rowHeight = 200
//        mainTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
    }
}

extension TVViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        
        let item = mainList[indexPath.item]
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(item.backdropPath)")
        
        cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
        
        print(item.name)
        
        cell.titleLabel.text = item.name
        
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
