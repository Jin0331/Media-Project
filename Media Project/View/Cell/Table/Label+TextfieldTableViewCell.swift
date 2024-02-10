//
//  Label+TextfieldTableViewCell.swift
//  Media Project
//
//  Created by JinwooLee on 2/10/24.
//

import UIKit
import Then
import SnapKit

class Label_TextfieldTableViewCell: BaseTableViewCell {
    
    let titleLabel = UILabel().then {
        $0.text = "hihihi"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 22, weight: .heavy)
    }
    
    let titleTextField = UITextField().then {
//        $0.text = "HIHIHIHIHIHI"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 22)
        $0.isUserInteractionEnabled = false
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleTextField)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(60)
//            make.verticalEdges.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(25)
        }
        
        titleTextField.snp.makeConstraints { make in
//            make.verticalEdges.equalToSuperview().inset(5)
            make.height.equalTo(titleLabel.snp.height)
            make.trailing.equalToSuperview().inset(5)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
        }
    }

}
