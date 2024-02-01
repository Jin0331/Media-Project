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
        view.backgroundColor = .clear
        return view
    }()
    let topViewImage : UIImageView = {
        let view  = UIImageView()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    let topViewTitle : UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .heavy)
        view.textColor = .white
        
        return view
    }()
    let topViewInformation : UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12, weight: .heavy)
        view.textColor = .white
        return view
    }()
    
    let topViewOverView : UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
        view.lineBreakMode = .byCharWrapping
        view.font = .systemFont(ofSize: 12, weight: .heavy)
        view.textColor = .systemGray2
        return view
    }()
    
    override func configureHierarch() {
        self.addSubview(topView)
        
        [topViewImage, topViewTitle, topViewInformation, topViewOverView].forEach { item in
            topView.addSubview(item)
        }
    }
    
    override func configureLayout() {
        // topView
        topView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        topViewImage.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(30)
            make.width.equalTo(50)
        }
        
        topViewTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        topViewInformation.snp.makeConstraints { make in
            make.top.equalTo(topViewTitle.snp.bottom).offset(5)
            make.leading.equalTo(topViewTitle)
            make.height.equalTo(15)
        }
        
        topViewOverView.snp.makeConstraints { make in
            make.top.equalTo(topViewInformation.snp.bottom).offset(3)
            make.leading.equalTo(topViewInformation)
            make.trailing.equalToSuperview().inset(180)
            make.bottom.greaterThanOrEqualToSuperview().inset(5)
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
    
    
    //    func configureHirerachy() {
    
    //
    //        view.addSubview(middleView)
    //        // middleSubView
    //        [middleLabel,middleCollectionView].map { item in
    //            return middleView.addSubview(item)
    //        }
    //
    //        view.addSubview(bottomView)
    
    
}

//    override func configureLayout() {
//        // topView
//        topView.snp.makeConstraints { make in
//            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(200)
//        }
//
//        topViewImage.snp.makeConstraints { make in
//            make.verticalEdges.trailing.equalToSuperview().inset(30)
//            make.width.equalTo(50)
//        }
//
//        topViewTitle.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(30)
//            make.leading.equalToSuperview().inset(15)
//            make.height.equalTo(50)
//        }
//
//        topViewInformation.snp.makeConstraints { make in
//            make.top.equalTo(topViewTitle.snp.bottom).offset(5)
//            make.leading.equalTo(topViewTitle)
//            make.height.equalTo(15)
//        }
//
//        topViewOverView.snp.makeConstraints { make in
//            make.top.equalTo(topViewInformation.snp.bottom).offset(3)
//            make.leading.equalTo(topViewInformation)
//            make.trailing.equalToSuperview().inset(180)
//            make.bottom.greaterThanOrEqualToSuperview().inset(5)
//        }
//
//        // middleView
//        middleView.snp.makeConstraints { make in
//            make.top.equalTo(topView.snp.bottom).offset(15)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(200)
//        }
//
//        middleLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.leading.equalToSuperview().inset(15)
//            make.height.equalTo(20)
//        }
//
//        middleCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(middleLabel.snp.bottom).offset(10)
//            make.horizontalEdges.equalToSuperview().inset(15)
//            make.height.equalTo(100)
//        }
//
//        bottomView.snp.makeConstraints { make in
//            make.top.equalTo(middleView.snp.bottom).offset(15)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(200)
//        }
//
//
//    }
//
//    override func configureView() {
//        guard let detailList = detailList else { return }
//
//        let url = URL(string: MediaAPIManager.CommonVariable.imageURL + detailList.backdropPath)!
//        topViewImage.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
//        topViewTitle.text = detailList.originalName
//        topViewInformation.text = detailList.mainText
//        topViewOverView.text = detailList.overview
//
//    }
//}
