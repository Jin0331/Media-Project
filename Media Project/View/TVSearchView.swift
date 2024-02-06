//
//  TVSearch.swift
//  Media Project
//
//  Created by JinwooLee on 2/5/24.
//

import UIKit
import Then
import SnapKit

class TVSearchView : BaseView {
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "TV 콘텐츠, 태그(not yet), 인물(not yet) 검색"
        $0.backgroundColor = .clear
        $0.showsCancelButton = false
        $0.barStyle = .black
        $0.searchBarStyle = .minimal
    }
    
    lazy var mainTableView = UITableView().then {
        //TODO: - Cell 변경 해야됨
        $0.register(TVSearchTableViewCell.self, forCellReuseIdentifier: TVSearchTableViewCell.identifier)
        $0.rowHeight = 200
        $0.backgroundColor = .clear
    }
    
    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureTVSearchCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.identifier)
    }
    
    override func configureHierarchy() {
        [searchBar, mainTableView,mainCollectionView].forEach { item in
            return self.addSubview(item)
        }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
    func configureTVSearchCollectionViewLayout() -> UICollectionViewFlowLayout {
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
