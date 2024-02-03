//
//  TVView.swift
//  Media Project
//
//  Created by JinwooLee on 2/2/24.
//

import UIKit
import Then

class TVView : BaseView {    
    lazy var mainTableView = UITableView().then {
        $0.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        $0.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.identifier)
//        $0.rowHeight = 300
        $0.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        self.addSubview(mainTableView)
    }
    
    override func configureLayout() {
        mainTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
    }
    
}
