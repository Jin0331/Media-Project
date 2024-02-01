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
        
        mainView.bottomLeftTableView.delegate = self
        mainView.bottomLeftTableView.dataSource = self
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchTV(api: .detail(id: self.tvSeriesId)) { (item : TVSeriesDetail ) in
                self.detailList = item
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaAPIManager.shared.fetchTV(api: .aggregate_credits(id: self.tvSeriesId)) { (item : TVSeriesAggregateCredit ) in
                self.aggregateCreditList = item
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("갱신완료")
            
            self.mainView.configureView(detailList: self.detailList)
            self.mainView.bottomLeftTableView.reloadData()
        }
    }
}

extension TVDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaAPI.TV.contentsInfoAllcases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.mainView.bottomLeftTableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVDetailTableViewCell.identifier, for: indexPath) as! TVDetailTableViewCell
                   
            cell.titleLabel.text = MediaAPI.TV.contentsInfoAllcases[indexPath.row].titleValue
            
            cell.subCollectionView.delegate = self
            cell.subCollectionView.dataSource = self
            cell.subCollectionView.tag = MediaAPI.TV.contentsInfoAllcases[indexPath.row].indexValue
            
            cell.subCollectionView.reloadData()
            
            return cell
        } else{
            return UITableViewCell()
        }
        
    }
}

extension TVDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
        return aggregateCreditList?.cast.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVDetailCollectionViewCell.identifier, for: indexPath) as! TVDetailCollectionViewCell
        
        if let aggregateCreditList = aggregateCreditList {
            
            if collectionView.tag == MediaAPI.TV.aggregate_credits(id: 0).indexValue { // 같은 콜렉션 뷰에서 나눠질때
                cell.profileImage.kf.setImage(with: URL(string: MediaAPI.baseImageUrl + aggregateCreditList.cast[indexPath.item].profilePath), placeholder: UIImage(systemName: "heart.fill"))
                cell.roleLabel.text = aggregateCreditList.cast[indexPath.item].roles[0].characterConvert
                cell.nameLabel.text = aggregateCreditList.cast[indexPath.item].originalName
                
                return cell
            } else {
                return cell // 여기는 나중에 적절한 API 넣으면 될 듯
            }
            

        } else {
          return UICollectionViewCell()
        }
        
    }
    
    
}
