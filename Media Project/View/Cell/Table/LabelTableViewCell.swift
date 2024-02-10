//
//  LabelTableViewCell.swift
//  Media Project
//
//  Created by JinwooLee on 2/10/24.
//

import UIKit
import SnapKit
import Then

class LabelTableViewCell: BaseTableViewCell {

    let titleLabel = UILabel().then {
        $0.textColor = .systemBlue
        $0.font = .systemFont(ofSize: 20, weight: .heavy)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }

}
