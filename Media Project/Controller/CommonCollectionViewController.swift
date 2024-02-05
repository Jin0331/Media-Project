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
    var genereList : TVSeriesRecommendations?
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        mainView.mainCollectionView.delegate = self
        mainView.mainCollectionView.dataSource = self
        
        let group = DispatchGroup()
        
        //MARK: - Configuration API request
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaSessionManager.shared.fetchURLSession(api: MediaAPI.SearchDetail.genere(id: 35)) { (item : TVSeriesRecommendations?, error : MediaAPI.APIError?) in
                if error == nil {
                    guard let item = item else { return }
                    self.genereList = item

                } else {
                    dump(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("갱신완료")
            
            dump(self.genereList)
            
        }
        
    }
    
}

extension CommonCollectionViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier, for: indexPath) as! CommonCollectionViewCell
        
        return cell
    }
    
    
}
