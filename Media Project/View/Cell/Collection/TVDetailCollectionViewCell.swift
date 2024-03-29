//
//  TVTableViewCell.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import UIKit

class TVDetailCollectionViewCell: BaseCollectionViewCell {
    
    
    let profileImage = PosterImageView(frame: .zero).then {_ in
        
    }
    
    let roleLabel = CommonTextLabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .heavy)
        $0.textColor = .white
    }
    
    let nameLabel = CommonTextLabel().then {
        $0.font = .systemFont(ofSize: 10, weight: .heavy)
        $0.textColor = .systemGray2
    }
    
    override func configureHierarchy() {
        contentView.addSubview(profileImage)
        contentView.addSubview(roleLabel)
        contentView.addSubview(nameLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layer.cornerRadius = 60
    }
    
    override func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(120)
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(5)
        }
        
        roleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(profileImage)
            make.top.equalTo(profileImage.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(profileImage)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(roleLabel)
            make.top.equalTo(roleLabel.snp.bottom)
        }
    }
    
    override func configureView() {

    }
}
