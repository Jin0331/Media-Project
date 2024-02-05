//
//  CommonCollcionView.swift
//  Media Project
//
//  Created by JinwooLee on 2/6/24.
//

import UIKit
import SnapKit
import Then

class CommonCollcionView : BaseView {
    
    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCommonCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.identifier)
    }
    
    override func configureHierarchy() {
        addSubview(mainCollectionView)
    }
    
    override func configureLayout() {
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func configureCommonCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let rowCount : Double = 3
        let sectionSpacing : CGFloat = 10
        let itemSpacing : CGFloat = 10
        let width : CGFloat = UIScreen.main.bounds.width - (itemSpacing * (rowCount - 1)) - (sectionSpacing * 2)
        let itemWidth: CGFloat = width / rowCount
        
        // 각 item의 크기 설정 (아래 코드는 정사각형을 그린다는 가정)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth+50)
        // 스크롤 방향 설정
        layout.scrollDirection = .vertical
        // Section간 간격 설정
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        // item간 간격 설정
        layout.minimumLineSpacing = itemSpacing        // 최소 줄간 간격 (수직 간격)
        layout.minimumInteritemSpacing = itemSpacing   // 최소 행간 간격 (수평 간격)
        
        return layout
        
    }
}
