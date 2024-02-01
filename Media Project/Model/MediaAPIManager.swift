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
        
    //MARK: - API Requet Function
    //TODO: - generic 적용 - 완
    func fetchTrend<T : Decodable>(api : MediaAPI.Trend, completionHandler : @escaping (T) -> Void) {
        
        AF.request(api.endPoint,
                   method: MediaAPI.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: MediaAPI.header)
        .responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let success):
                print("조회 성공")
                
                completionHandler(success)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTV<T : Decodable>(api : MediaAPI.TV, completionHandler : @escaping (T) -> Void) {
        
        AF.request(api.endPoint,
                   method: MediaAPI.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: MediaAPI.header)
        .responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let success):
                print("조회 성공")
                
                completionHandler(success)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
}

/*
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

 */
