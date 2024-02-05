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
    
    let mainView = TVDetailView()
//    override var tvID: Int =
    var detailList : TVSeriesDetail?
    var aggregateCreditList : TVSeriesAggregateCredit?
    var recommendationsList : TVSeriesRecommendations?

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mainView.bottomLeftTableView.delegate = self
        mainView.bottomLeftTableView.dataSource = self
        mainView.bottomLeftTableView.isHidden = false
        
        mainView.bottomRightTableView.delegate = self
        mainView.bottomRightTableView.dataSource = self
        mainView.bottomRightTableView.isHidden = true
        
        
        //MARK: - Call Request
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchAF(api: .detail(id: self.tvID)) { (item : TVSeriesDetail ) in
                self.detailList = item
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchAF(api: .aggregate_credits(id: self.tvID)) { (item : TVSeriesAggregateCredit ) in
                self.aggregateCreditList = item
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchAF(api: .recommendations(id: self.tvID)) { (item : TVSeriesRecommendations ) in
                self.recommendationsList = item
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("갱신완료")
            
            self.mainView.configureView(detailList: self.detailList)
            self.mainView.bottomLeftTableView.reloadData()
            self.mainView.bottomRightTableView.reloadData()
        }
        
        //MARK: - button action, button 클릭에 따라 table view hidden
        mainView.middleLeftButton.addTarget(self, action: #selector(middleButtonClicked), for: .touchUpInside)
        mainView.middleRightButton.addTarget(self, action: #selector(middleButtonClicked), for: .touchUpInside)
        }
    
    
    override func configureNavigation() {
        super.configureNavigation()
        navigationItem.title = ""
    }
    
    @objc func middleButtonClicked(sender : UIButton){
        mainView.bottomLeftTableView.isHidden.toggle()
        mainView.bottomRightTableView.isHidden.toggle()
    }
}

extension TVDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.mainView.bottomLeftTableView == tableView{
            return MediaAPI.TV.contentsInfoAllcases.count
        } else {
            return MediaAPI.TV.relatedContentsAllcases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TVDetailTableViewCell.identifier, for: indexPath) as! TVDetailTableViewCell
        cell.subCollectionView.delegate = self
        cell.subCollectionView.dataSource = self
        
        //MARK: - 항목이 2개이므로, 삼항 연산자 가능
        let dataModel = self.mainView.bottomLeftTableView == tableView ? MediaAPI.TV.contentsInfoAllcases[indexPath.row] : MediaAPI.TV.relatedContentsAllcases[indexPath.row]
        cell.titleLabel.text = dataModel.titleValue
        cell.subCollectionView.layer.name = dataModel.caseValue
        cell.subCollectionView.tag = dataModel.indexValue
        cell.subCollectionView.reloadData()
        
        return cell
    }
}

extension TVDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return MediaAPI.TV.contentsInfoAllcases.map({ item in
            return item.caseValue
        }).contains(collectionView.layer.name) ? aggregateCreditList?.cast.count ?? 0 : recommendationsList?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let recommendationsList {
            MediaAPI.TV.relatedContentsAllcases.map({ item in
                return item.caseValue
            }).contains(collectionView.layer.name) ? tvViewTransition(style: .present, viewController: TVDetailViewController.self, tvID: recommendationsList.results[indexPath.item].id) : nil
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                        
        if MediaAPI.TV.contentsInfoAllcases.map({ item in
            return item.caseValue
        }).contains(collectionView.layer.name){ // 만약 layer name이 콘텐츠 정보에 포함된다면
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVDetailCollectionViewCell.identifier, for: indexPath) as! TVDetailCollectionViewCell
            
            if let aggregateCreditList = aggregateCreditList {
                
                if collectionView.tag == MediaAPI.TV.aggregate_credits(id: 0).indexValue { // 출연 및 관련 동영상 구분하기 위한 tag 사용
                    
                    cell.profileImage.kf.setImage(with: URL(string: MediaAPI.baseImageUrl + (aggregateCreditList.cast[indexPath.item].profilePath ?? "")), options: [.transition(.fade(1))])
                    cell.roleLabel.text = aggregateCreditList.cast[indexPath.item].roles[0].characterConvert
                    cell.nameLabel.text = aggregateCreditList.cast[indexPath.item].originalName
                } else {
                    //TODO: - 아직 추가되지 않은 관련 동영상 항목
                    print("관련 동영상 입니다. - aggregateCreditList")
                }
                
            } else {
                print("Optional 들어옴 ", #function)
            }
            
            return cell
            
            //MARK: - 관련 콘텐츠(비슷한 영상)
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier, for: indexPath) as! CommonCollectionViewCell
            if let recommendationsList = recommendationsList {
                if collectionView.tag == MediaAPI.TV.recommendations(id: 0).indexValue { // 출연 및 관련 동영상 구분하기 위한 tag 사용
                    cell.posterImageView.kf.setImage(with: URL(string: MediaAPI.baseImageUrl + recommendationsList.results[indexPath.item].posterPath), options: [.transition(.fade(1))])
                } else {
                    //TODO: - 아직 추가되지 않은 관련 동영상 항목
                    print("관련 동영상 입니다. - recommendations")
                }
                
            } else {
                print("Optional 들어옴 ", #function)
            }
            
            return cell
        }
    }
    
    
}
