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
    }
    
    lazy var mainTableView = UITableView().then {
        //TODO: - Cell 변경 해야됨
        $0.register(TVSearchTableViewCell.self, forCellReuseIdentifier: TVSearchTableViewCell.identifier)
        $0.rowHeight = 300
        $0.backgroundColor = .red
    }
    
    override func configureHierarchy() {
        [searchBar, mainTableView].forEach { item in
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
        
    }
    
    
    
    
}
