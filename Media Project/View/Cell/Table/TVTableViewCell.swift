//
//  TVTableViewCell.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import UIKit

class TVTableViewCell: BaseTableViewCell {
    
    let titleLabel = CommonTextLabel()
    lazy var subCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
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
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    override func configureView() {
        backgroundColor = .clear
        subCollectionView.backgroundColor = .clear
        titleLabel.backgroundColor = .clear
        titleLabel.font = .systemFont(ofSize: 22, weight: .heavy)
        titleLabel.textColor = .white
    }
    
    override func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 240)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
