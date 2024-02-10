//
//  BaseViewController.swift
//  Media Project
//
//  Created by JinwooLee on 1/31/24.
//

import UIKit

class BaseViewController: UIViewController{
    
    var tvID : Int = 0
    var genreID : Int = 0
    var countryID : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black //TODO: - Style 통일화를 위한 Enum 필요함. 추후 구현
        
        configureHirerachy()
        configureLayout()
        configureView()
        configureNavigation ()
    }
    
    func configureHirerachy() {
    }
    
    func configureLayout() {
    }
    
    func configureView() {
    }
    
    func configureNavigation () {
        // background color
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        // font setting
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25, weight: .heavy)
        ]
        
        // back button
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // profile button
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "figure.child.circle"), style: .plain, target: self, action: #selector(profileButtonClicked))
        profileButton.tintColor = .white
        
        //  item 설정
        navigationItem.rightBarButtonItem = profileButton
        navigationItem.title = ""
        
    }
    
    // profile button 누를때 동작
    @objc func profileButtonClicked(_ sender : UIBarButtonItem) {
        
//        print(#function)
        ViewTransition(style: .push, viewController: ProfileViewController.self)
    }
}

//MARK: - 화면전환관련
extension BaseViewController {
    
    enum TransitionStyle {
        case present
        case presentNavigation // 네비게이션 임베드한 채로 present
        case presentFullNavigation // 네비게이션 임베드 된 full presesnt
        case push
    }
    
    //MARK: - overload로 진행함.
    // tvID
    func ViewTransition<T:BaseViewController>(style : TransitionStyle, viewControllerType : T.Type, tvID : Int) {
        let vc = T()
        vc.tvID = tvID
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // genreID
    func ViewTransition<T:BaseViewController>(style : TransitionStyle, viewControllerType : T.Type, genreID : Int) {
        let vc = T()
        vc.genreID = genreID
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // courntryID
    func ViewTransition<T:BaseViewController>(style : TransitionStyle, viewControllerType : T.Type, countryID : String) {
        let vc = T()
        vc.countryID = countryID
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // 매개 변수 x
    func ViewTransition<T:BaseViewController>(style : TransitionStyle, viewController : T.Type) {
        let vc = T()
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
