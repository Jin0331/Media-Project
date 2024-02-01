//
//  TVView.swift
//  Media Project
//
//  Created by JinwooLee on 2/2/24.
//

import UIKit

class TVView : BaseView {
    
    lazy var mainCollectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.identifier)
        view.backgroundColor = .clear
        view.isPagingEnabled = true
        
        return view
    }()
    
    let mainTableView : UITableView = {
        let view = UITableView()
        view.rowHeight = 300
        view.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        view.backgroundColor = .clear
        
        return view
    }()
    
    
    override func configureHierarchy() {
        self.addSubview(mainCollectionView)
        self.addSubview(mainTableView)
    }
    
    override func configureLayout() {
        mainCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(mainCollectionView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
    }
    
}
