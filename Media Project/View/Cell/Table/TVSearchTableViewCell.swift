//
//  TVSearchTableViewCell.swift
//  Media Project
//
//  Created by JinwooLee on 2/5/24.
//

import UIKit

class TVSearchTableViewCell : BaseTableViewCell {
    
    let titleLabel = CommonTextLabel().then {
        $0.backgroundColor = .clear
        $0.font = .systemFont(ofSize: 22, weight: .heavy)
        $0.textColor = .white
    }
    
    lazy var subCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureTVSearchCollectionViewLayout()).then {
        $0.backgroundColor = .clear
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
        }
        subCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    override func configureView() {
        backgroundColor = .clear
    }
    
    func configureTVSearchCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 150)
        layout.minimumLineSpacing = 10 // item간 간격
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
