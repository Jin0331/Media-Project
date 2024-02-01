//
//  TVCollectionViewCell.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import UIKit
import SnapKit

class CommonCollectionViewCell: UICollectionViewCell {
    let posterImageView = PosterImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        setUpConstraint()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    func configureView(){
        posterImageView.image = UIImage(systemName: "person")
    }
    
    func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    func setUpConstraint() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
