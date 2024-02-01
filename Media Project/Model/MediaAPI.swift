//
//  MediaAPI.swift
//  Media Project
//
//  Created by JinwooLee on 2/1/24.
//

import Foundation
import Alamofire

enum MediaAPI {
    
    static var baseImageUrl = "https://image.tmdb.org/t/p/w500/"
    static var baseUrl =  "https://api.themoviedb.org/3/"
    static var header : HTTPHeaders = ["Authorization" : API.TMDBAPI]
    static var method : HTTPMethod = .get
    
    enum Trend : CaseIterable{
        static var allCases : [Trend] {
            return [.trend, .popular(page: 1), .top_rated(page: 1)]
        }
        
        case trend
        case popular(page:Int)
        case top_rated(page:Int)

        var endPoint : URL {
            get {
                switch self {
                case .trend:
                    return URL(string: MediaAPI.baseUrl + "trending/tv/week")!
                case .top_rated:
                    return URL(string: MediaAPI.baseUrl + "tv/top_rated")!
                case .popular:
                    return URL(string: MediaAPI.baseUrl + "tv/popular")!
                }
            }
        }
        
        var parameter : Parameters {
            switch self {
            case .trend:
                return ["language":"ko-KR"]
            case .top_rated(let page), .popular(let page):
                return ["language":"ko-KR", "page": page]
            }
        }
        
        var indexValue : Int {
            switch self {
            case .trend :
                return 0
            case .popular :
                return 1
            case .top_rated :
                return 2

            }
        }
        var textValue : String {
            switch self {
            case .top_rated:
                return "Top Rated TV SERIES"
            case .popular :
                return "Popular TV SERIES"
            case .trend :
                return "Trend"
            }
        }
        
    }
    
    enum TV : CaseIterable{
        static var allCases: [TV] {
            return [.detail(id: 0), recommendations(id: 0, page: 0), .aggregate_credits(id: 0, page: 0)]
        }
        
        case detail(id:Int)
        case recommendations(id:Int, page : Int)
        case aggregate_credits(id:Int, page : Int)
        
        var endPoint : URL {
            get {
                switch self {
                case .detail(let id):
                    return URL(string: MediaAPI.baseUrl + "tv/\(id)")!
                case .recommendations(let id):
                    return URL(string: MediaAPI.baseUrl + "tv/\(id)/recommendations")!
                case .aggregate_credits(let id) :
                    return URL(string: MediaAPI.baseUrl + "tv/\(id)/aggregate_credits")!
                }
            }
        }
        
        var parameter : Parameters {
            switch self {
            case  .detail :
                return ["language":"ko-KR"]
            case .recommendations(let page), .aggregate_credits(let page):
                return ["language":"ko-KR", "page": page]
            }
        }
        
        var caseValue : String {
            switch self {
            default :
                return String(describing: self)
            }
        }
        
        var textValue : String {
            switch self {
            case .recommendations :
                return "비슷한 콘텐츠"
            case .aggregate_credits :
                return "출연"
            default:
                return "None"
            }
        }
        
    }
    
}

