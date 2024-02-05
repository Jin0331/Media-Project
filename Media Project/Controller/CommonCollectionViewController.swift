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
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        mainView.mainCollectionView.delegate = self
        mainView.mainCollectionView.dataSource = self
    }
}

extension CommonCollectionViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier, for: indexPath) as! CommonCollectionViewCell
        
        return cell
    }
    
    
}
