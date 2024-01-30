//
//  CommonTextLabel.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import UIKit

class CommonTextLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.font = .systemFont(ofSize: 15, weight: .heavy)
        self.textAlignment = .left
        self.numberOfLines = 2
        self.backgroundColor = .clear
    }
}
