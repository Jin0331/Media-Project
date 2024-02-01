//
//  TVDetailView.swift
//  Media Project
//
//  Created by JinwooLee on 2/1/24.
//

import UIKit

class TVDetailView : BaseView {
    //MARK: - UI Variable
    let topView : UIView = {
        let view = UIView()
        return view
    }()
    let topViewImage : UIImageView = {
        let view  = UIImageView()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    let topViewTitle : UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 30, weight: .heavy)
        view.textColor = .black
        
        return view
    }()
    let topViewInformation : UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12, weight: .heavy)
        view.textColor = .black
        return view
    }()
    let topViewOverView : UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
        view.lineBreakMode = .byCharWrapping
        view.font = .systemFont(ofSize: 12, weight: .heavy)
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    
    // middle button
    let middleStackView : UIStackView = {
        let view  = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 8
        
        return view
    }()
    let middleLeftButton : UIButton = {
        let view = UIButton()
        view.setTitle("콘텐츠 정보", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 15, weight: .heavy)
        view.backgroundColor = .clear
        
        return view
    }()
    let middleRightButton : UIButton = {
        let view = UIButton()
        view.setTitle("관련 콘텐츠", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 15, weight: .heavy)
        view.backgroundColor = .clear
        
        return view
    }()
    
    let bottomLeftTableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.rowHeight = 250
        view.register(TVDetailTableViewCell.self, forCellReuseIdentifier: TVDetailTableViewCell.identifier)
        
        return view
    }()
    
    let bottomRightTableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.rowHeight = 250
        view.register(TVDetailTableViewCell.self, forCellReuseIdentifier: TVDetailTableViewCell.identifier)
        
        return view
    }()
    
    
    
    // bottom table view
    
    override func configureHierarch() {
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
            make.height.equalTo(UIScreen.main.bounds.height / 3 * 1)
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

    override func configureView(detailList : TVSeriesDetail?) {
        
        if let detailList = detailList {
            let url = URL(string: MediaAPI.baseImageUrl + detailList.backdropPath)!
            topViewImage.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
            topViewTitle.text = detailList.originalName
            topViewInformation.text = detailList.mainText
            topViewOverView.text = detailList.overview
        }
    }
    
    func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
