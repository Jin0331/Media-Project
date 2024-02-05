//
//  TVSearchViewController.swift
//  Media Project
//
//  Created by JinwooLee on 2/5/24.
//

import UIKit

class TVSearchViewController : BaseViewController {
    
    let mainView = TVSearchView()
    var countries : Countries?
    var genre : Genres?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    
    
    override func configureNavigation() {
        super.configureNavigation()
        navigationItem.title = "찾기"
    }

}


