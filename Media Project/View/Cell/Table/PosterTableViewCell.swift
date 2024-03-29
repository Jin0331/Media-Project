//
//  PosterTableViewCell.swift
//  Media Project
//
//  Created by JinwooLee on 2/3/24.
//

import UIKit
import Then

class PosterTableViewCell : BaseTableViewCell {
    
    let titleLabel = CommonTextLabel().then {
        $0.backgroundColor = .clear
        $0.font = .systemFont(ofSize: 22, weight: .heavy)
        $0.textColor = .white
    }
    
    let posterImageView =  PosterImageView(frame: .zero).then {_ in
    }
    
    let emptyButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("", for: .normal)
    }
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(posterImageView)
        addSubview(emptyButton)
    }
    
    //TODO: - 동적 이미지 필요?
    override func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(10)
            make.height.equalTo(30)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        emptyButton.snp.makeConstraints { make in
            make.edges.equalTo(posterImageView)
        }
    }
    
    func configureView(dataList : TVTrendModel?) {
        
        if let dataList = dataList {
            let randomTrendTV = dataList.results[0]
            if let posterPath = randomTrendTV.posterPath {
                let url = URL(string: MediaAPI.baseImageUrl + posterPath)!
                posterImageView.kf.setImage(with: url, options: [.transition(.fade(1))])
            } 
        }
    }
    
    
}
