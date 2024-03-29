//
//  TVTableViewCell.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import UIKit

class TVDetailTableViewCell: BaseTableViewCell {
    
    let titleLabel = CommonTextLabel().then {
        $0.backgroundColor = .clear
        $0.font = .systemFont(ofSize: 22, weight: .heavy)
        $0.textColor = .white
    }
    lazy var subCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureTVDetailCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.register(TVDetailCollectionViewCell.self, forCellWithReuseIdentifier: TVDetailCollectionViewCell.identifier)
        $0.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.identifier)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subCollectionView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(10)
            make.height.equalTo(30)
            make.trailing.lessThanOrEqualToSuperview()
        }
        subCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    override func configureView() {
        backgroundColor = .clear

    }
    
    func configureTVDetailCollectionViewLayout() -> UICollectionViewFlowLayout {
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
