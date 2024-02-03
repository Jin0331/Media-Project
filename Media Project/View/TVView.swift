//
//  TVView.swift
//  Media Project
//
//  Created by JinwooLee on 2/2/24.
//

import UIKit

class TVView : BaseView {

    let mainTableView : UITableView = {
        let view = UITableView()
        view.rowHeight = 300
        view.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        view.backgroundColor = .clear
        
        return view
    }()
    
    
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
