//
//  ProfileTableViewCell.swift
//  Media Project
//
//  Created by JinwooLee on 2/10/24.
//

import UIKit
import SnapKit
import Then

class ProfileTableViewCell : BaseTableViewCell {
    
    let mainTableView = UITableView().then {
        $0.register(Label_TextfieldTableViewCell.self, forCellReuseIdentifier: Label_TextfieldTableViewCell.identifier)
        $0.backgroundColor = .clear
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 80
    }
    
    override func configureHierarchy() {
        addSubview(mainTableView)
    }
    
    override func configureLayout() {
        mainTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
