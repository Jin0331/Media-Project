//
//  TVDetailViewController.swift
//  Media Project
//
//  Created by JinwooLee on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher


class TVDetailViewController: BaseViewController {
    
    //MARK: - UI Variable
    let topView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    let topViewImage : UIImageView = {
        let view  = UIImageView()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    let topViewTitle : UILabel = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .heavy)
        view.textColor = .white
        
        return view
    }()
    let topViewInformation : UILabel = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 12, weight: .heavy)
        view.textColor = .white
        return view
    }()
    let topViewOverView : UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
        view.lineBreakMode = .byCharWrapping
        view.font = .systemFont(ofSize: 12, weight: .heavy)
        view.textColor = .systemGray2
        return view
    }()
    
    let middleView : UIView = {
        let view = UIView()
//        view.backgroundColor = .red
        return view
    }()
    
    let middleLabel : UILabel = {
        let view = UILabel()
//        view.backgroundColor = .blue
        view.textColor = .white
        view.font = .systemFont(ofSize: 20, weight: .heavy)
        view.text = "관련 콘텐츠"
        
        return view
    }()
    
    lazy var middleCollectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.delegate = self
        view.dataSource = self
        view.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.identifier)
//        print(#function, CommonCollectionViewCell.identifier)
        
        return view
    }()
    
//    let bottomView : UIView = {
//        let view = UIView()
//        view.backgroundColor = .blue
//        return view
//    }()
//    let bottomLabel = UILabel()
//    lazy var bottomCollectionView : UICollectionView = {
//        let view = UICollectionView(frame: .zero, collectionViewLayout: <#T##UICollectionViewLayout#>)
//        view.delegate = self
//        view.dataSource = self
//        view.register(SearchViewCollectionViewCell.self, forCellWithReuseIdentifier: "Search")
//        
//        return view
//    }()
//    
    //MARK: - Data
    var tvSeriesId = 96102 //TODO: - Search TV API로 값 전달 받으면 됨
    var detailList : TVSeriesDetail?
    var recommendationsList : TVSeriesRecommendations?
    var aggregateCreditList : TVSeriesAggregateCredit?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchTVSeriesDetail(id: self.tvSeriesId) { item in
                self.detailList = item
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchTVSeriesRecommendations(id: self.tvSeriesId) { item in
                self.recommendationsList = item
                group.leave()
            }
        }
            
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchTVSeriesAggregateCredits(id: self.tvSeriesId) { item in
                self.aggregateCreditList = item
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("갱신완료")
            
            self.configureView()
            self.middleCollectionView.reloadData()
            
//            print(self.recommendationsList)
        }
    }
    
    override func configureHirerachy() {
        view.addSubview(topView)
        // topViewSubView
        [topViewImage, topViewTitle, topViewInformation, topViewOverView].map { item in
            return topView.addSubview(item)
        }
        
        view.addSubview(middleView)
        // middleSubView
        [middleLabel,middleCollectionView].map { item in
            return middleView.addSubview(item)
        }
        
        
    }
    
    override func configureLayout() {
        // topView
        topView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        topViewImage.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(30)
            make.width.equalTo(50)
        }
        
        topViewTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        topViewInformation.snp.makeConstraints { make in
            make.top.equalTo(topViewTitle.snp.bottom).offset(5)
            make.leading.equalTo(topViewTitle)
            make.height.equalTo(15)
        }
        
        topViewOverView.snp.makeConstraints { make in
            make.top.equalTo(topViewInformation.snp.bottom).offset(3)
            make.leading.equalTo(topViewInformation)
            make.trailing.equalToSuperview().inset(180)
            make.bottom.greaterThanOrEqualToSuperview().inset(5)
        }
        
        // middleView
        middleView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        middleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.height.equalTo(20)
        }
        
        middleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(middleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        
    }
    
    override func configureView() {
        guard let detailList = detailList else { return }
        
        let url = URL(string: MediaAPIManager.CommonVariable.imageURL + detailList.backdropPath)!
        topViewImage.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
        topViewTitle.text = detailList.originalName
        topViewInformation.text = detailList.mainText
        topViewOverView.text = detailList.overview

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
        let url = URL(string: MediaAPIManager.CommonVariable.imageURL + item.posterPath)!
        cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
        
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
