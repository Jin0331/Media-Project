//
//  TVDetailView.swift
//  Media Project
//
//  Created by JinwooLee on 2/1/24.
//

import UIKit
import Then

class TVDetailView : BaseView {
    
    //MARK: - UI Variable
    let topView = UIView().then {view in}
    let topViewImage = PosterImageView(frame: .zero).then {
        $0.alpha = 0.6
    }
    
    let topViewTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 30, weight: .heavy)
        $0.textColor = .white
    }
    
    let topViewInformation = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .heavy)
        $0.textColor = .white
    }
    
    let topViewOverView = UILabel().then {
        $0.numberOfLines = 3
        $0.lineBreakMode = .byCharWrapping
        $0.font = .systemFont(ofSize: 12, weight: .heavy)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    // middle button
    let middleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    
    let middleLeftButton = UIButton().then {
        $0.setTitle("콘텐츠 정보", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .heavy)
        $0.backgroundColor = .clear
        $0.layer.name = "left"
    }
    
    let middleRightButton = UIButton().then {
        $0.setTitle("관련 콘텐츠", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .heavy)
        $0.backgroundColor = .clear
        $0.layer.name = "right"
    }
    
    let bottomLeftTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.rowHeight = UIScreen.main.bounds.height / 2
        $0.register(TVDetailTableViewCell.self, forCellReuseIdentifier: TVDetailTableViewCell.identifier)
    }
    
    let bottomRightTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.rowHeight = UIScreen.main.bounds.height
        $0.register(TVDetailTableViewCell.self, forCellReuseIdentifier: TVDetailTableViewCell.identifier)
    }
    
    // bottom table view
    
    override func configureHierarchy() {
        self.addSubview(topView)
        
        [topViewImage, topViewTitle, topViewInformation, topViewOverView].forEach { item in
            topView.addSubview(item)
        }
        
        self.addSubview(middleStackView)
        
        [middleLeftButton, middleRightButton].forEach { item in
            middleStackView.addArrangedSubview(item)
        }
        
        self.addSubview(bottomLeftTableView)
        self.addSubview(bottomRightTableView)
    }
    
    override func configureLayout() {
        // topView
        topView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
        
        topViewImage.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        
        topViewTitle.snp.makeConstraints { make in
            make.centerX.equalTo(topView)
            make.centerY.equalTo(topView).offset(40)
        }
        
        topViewInformation.snp.makeConstraints { make in
            make.centerX.equalTo(topView)
            make.top.equalTo(topViewTitle.snp.bottom).offset(10)
        }
        
        topViewOverView.snp.makeConstraints { make in
            make.centerX.equalTo(topView)
            make.horizontalEdges.equalTo(topView).inset(10)
            make.top.equalTo(topViewInformation.snp.bottom).offset(10)
        }
        
        middleStackView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.horizontalEdges.equalTo(topView)
            make.height.equalTo(60)
        }
        
        bottomLeftTableView.snp.makeConstraints { make in
            make.top.equalTo(middleStackView.snp.bottom)
            make.horizontalEdges.equalTo(middleStackView)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        bottomRightTableView.snp.makeConstraints { make in
            make.top.equalTo(middleStackView.snp.bottom)
            make.horizontalEdges.equalTo(middleStackView)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }

    func configureView(detailList : TVSeriesDetail?) {
        
        if let detailList = detailList {
            let url = URL(string: MediaAPI.baseImageUrl + detailList.backdropPath)!
            topViewImage.kf.setImage(with: url, options: [.transition(.fade(1))])
            topViewTitle.text = detailList.originalName
            topViewInformation.text = detailList.mainText
            topViewOverView.text = detailList.overview
        }
    }
    
    override func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout().then {
            $0.itemSize = CGSize(width: 50, height: 50)
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.scrollDirection = .horizontal
        }        
        return layout
    }
}
