//
//  TVCollectionViewCell.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import UIKit
import SnapKit

class CommonCollectionViewCell: BaseCollectionViewCell {
    let posterImageView = PosterImageView(frame: .zero).then{
        $0.backgroundColor = UIColor(red: CGFloat.random(in: 0..<0.9),
                                     green: CGFloat.random(in: 0..<0.9),
                                     blue: CGFloat.random(in: 0..<0.9),
                                     alpha: 1)
    }
    
    let titleLabel = CommonTextLabel().then {
        $0.backgroundColor = .clear
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.textColor = .white
    }
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
    }
        
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.top).inset(30)
            make.leading.equalTo(posterImageView).inset(15)
        }
    }
}
