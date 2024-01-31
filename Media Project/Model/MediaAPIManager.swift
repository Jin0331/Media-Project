//
//  MediaAPIManager.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import UIKit
import Alamofire

class MediaAPIManager {
    static let shared = MediaAPIManager()
    
    private init () { }
    
    //MARK: - TVSeries 콘텐츠 목록
    enum TVSeries : Int, CaseIterable {
        case top_rated
        case popular
        case recommendations
        case aggregate_credits
        
        var caseValue : String {
            switch self {
            default :
                return String(describing: self)
            }
        }
        var textValue : String {
            switch self {
            case .top_rated:
                return "Top Rated TV SERIES"
            case .popular :
                return "Popular TV SERIES"
            case .recommendations :
                return "비슷한 콘텐츠"
            case .aggregate_credits :
                return "출연"
            default:
                return "None"
            }
        }
    }
    
    
    
    //MARK: - 공통 변수
    struct CommonVariable {
        static let imageURL = "https://image.tmdb.org/t/p/w500"
        static let tvTrendingBaseURL = "https://api.themoviedb.org/3/trending/tv/"
        static let tvBaseURL = "https://api.themoviedb.org/3/tv/"
        static let header : HTTPHeaders = ["Authorization" : API.TMDBAPI]
    }
    
    //MARK: - API Requet Function
    func fetchTrendingTV(completionHandler : @escaping (([TrendTV]) -> Void)) {
        let url = CommonVariable.tvTrendingBaseURL + "week?language=ko-KR"
        
        // 비동기 처리
        AF.request(url, method: .get, headers: CommonVariable.header).responseDecodable(of: TrendTVModel.self) { response in
            
            switch response.result {
            case .success(let success):
                print("조회 성공")
                
                completionHandler(success.results)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    //TODO: - Top Rate과 Popular는 url이 유사하므로, 매개변수를 받아서 사용하고, pagination 적용
    func fetchTVSeriesLists(contents : String, page : Int, completionHandler : @escaping ([TVSeriesLists]) -> Void){
        let url = CommonVariable.tvBaseURL + "\(contents)?language=ko-KR&page=\(page)"
        
        AF.request(url, method: .get, headers: CommonVariable.header).responseDecodable(of: TVSeriesListsModel.self) { response in
            
            switch response.result {
            case .success(let success):
                print("조회 성공")
                
                completionHandler(success.results)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTVSeriesDetail(id : Int, completionHandler : @escaping (TVSeriesDetail) -> Void){
        let url = CommonVariable.tvBaseURL + "\(id)?language=ko-KR"
        print(url)
        
        AF.request(url, method: .get, headers: CommonVariable.header).responseDecodable(of: TVSeriesDetail.self) { response in
            
            switch response.result {
            case .success(let success):
                print("조회 성공")
                
                completionHandler(success)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTVSeriesRecommendations(id : Int, completionHandler : @escaping (TVSeriesRecommendations) -> Void){
        let url = CommonVariable.tvBaseURL + "\(id)/recommendations?language=ko-KR"
        
        AF.request(url, method: .get, headers: CommonVariable.header).responseDecodable(of: TVSeriesRecommendations.self) { response in
            
            switch response.result {
            case .success(let success):
                print("조회 성공")
                
                completionHandler(success)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTVSeriesAggregateCredits(id : Int, completionHandler : @escaping (TVSeriesAggregateCredit) -> Void){
        let url = CommonVariable.tvBaseURL + "\(id)/aggregate_credits?language=ko-KR"
        
        AF.request(url, method: .get, headers: CommonVariable.header).responseDecodable(of: TVSeriesAggregateCredit.self) { response in
            
            switch response.result {
            case .success(let success):
                print("조회 성공")
                
                completionHandler(success)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
    
    
//    func fetchTVSeries(id : Int, contents : String = "") {
//        let contents_ = contents != "" ? "/\(contents)" : contents
//        let url = CommonVariable.tvBaseURL + "\(id)\(contents_)?language=ko-KR"
//        var rawValue = TVSeries.allCases.map { item in
//            return item.caseValue == contents ? item.rawValue : nil }
//            .compactMap { return $0 }[0]
//        let modelName = TVSeries(rawValue: rawValue)?.modelName ?? Any.self
//        
//        AF.request(url, method: .get, headers: CommonVariable.header).responseDecodable(of: modelName as! TVSeriesListsModel.Type) { response in
//            
//            switch response.result {
//            case .success(let success):
//                print("조회 성공")
//                
////                completionHandler(success.results)
//                
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
    
    
}
