//
//  PosterImageView.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import UIKit

class PosterImageView : UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.backgroundColor = .lightGray
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
}
