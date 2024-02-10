//
//  WebKitTableViewCell.swift
//  Media Project
//
//  Created by JinwooLee on 2/10/24.
//

import UIKit
import SnapKit
import Then
import WebKit

class WebKitTableViewCell: BaseTableViewCell {

    let titleLabel = CommonTextLabel().then {
        $0.backgroundColor = .clear
        $0.font = .systemFont(ofSize: 22, weight: .heavy)
        $0.textColor = .white
    }
    
    let videoWebKit = WKWebView().then {
        $0.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(videoWebKit)
    }
    
    override func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(10)
            make.height.equalTo(30)
            make.trailing.lessThanOrEqualToSuperview()
        }
        videoWebKit.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    override func configureView() {
        backgroundColor = .clear

    }
    
    func getVideo(videoKey:String){
        guard let url = URL(string: "\(MediaAPI.baseVideoUrl)\(videoKey)") else { return }
        print(url)
        videoWebKit.load(URLRequest(url: url))
    }

}
