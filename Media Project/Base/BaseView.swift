//
//  BaseView.swift
//  Media Project
//
//  Created by JinwooLee on 2/1/24.
//

import UIKit
import SnapKit

class BaseView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarch()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarch() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        
    }
    
    // overload
    func configureView(detailList : TVSeriesDetail) {

    }
}




//
//
////MARK: - UI Variable
//let middleView : UIView = {
//    let view = UIView()
////        view.backgroundColor = .red
//    return view
//}()
//
//let middleLabel : UILabel = {
//    let view = UILabel()
////        view.backgroundColor = .blue
//    view.textColor = .white
//    view.font = .systemFont(ofSize: 20, weight: .heavy)
//    view.text = "관련 콘텐츠"
//    
//    return view
//}()
//
//lazy var middleCollectionView : UICollectionView = {
//    let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
//    view.delegate = self
//    view.dataSource = self
//    view.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.identifier)
//    view.reloadData()
////        print(#function, CommonCollectionViewCell.identifier)
//    
//    return view
//}()
//
//let bottomView : UIView = {
//    let view = UIView()
//    view.backgroundColor = .blue
//    return view
//}()
////    let bottomLabel = UILabel()
////    lazy var bottomCollectionView : UICollectionView = {
////        let view = UICollectionView(frame: .zero, collectionViewLayout: <#T##UICollectionViewLayout#>)
////        view.delegate = self
////        view.dataSource = self
////        view.register(SearchViewCollectionViewCell.self, forCellWithReuseIdentifier: "Search")
////
////        return view
////    }()
////
