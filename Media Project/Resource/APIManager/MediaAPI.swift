//
//  MediaAPI.swift
//  Media Project
//
//  Created by JinwooLee on 2/1/24.
//

import Foundation
import Alamofire


enum MediaAPI {
    
//    static let baseVideoUrl = "https://www.youtube.com/watch?v="
    static let baseVideoUrl = "https://www.youtube.com/embed/"
    static let baseImageUrl = "https://image.tmdb.org/t/p/w500/"
    static let baseUrl =  "https://api.themoviedb.org/3/"
    static let header : HTTPHeaders = ["Authorization" : API.TMDBAPI]
    static let method : HTTPMethod = .get
    
    //MARK: - Error 관련 Enum
    enum APIError : Error {
        case failedRequeset
        case noData
        case invalidResponse
        case invalidData
        case invalidDecodable
    }

    
    //MARK: - 화면별로 API 관리됨.일단은
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
                    return URL(string: MediaAPI.baseUrl + "trending/tv/day")!
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
                return "청중의 극찬을 받은 TV 시리즈"
            case .popular :
                return "인기 TV 시리즈"
            case .trend :
                return "오늘의 추천작"
            }
        }
        
        var caseValue : String {
            switch self {
            default :
                return String(describing: self)
            }
        }
        
        static func searchByIndex(value : Int) -> MediaAPI.Trend {
            
            switch value {
            case 0 :
                return .trend
            case 1 :
                return .popular(page: 0)
            case 2 :
                return .top_rated(page: 0)
            default :
                return .trend
            }
        }
        
    }
    
    enum TV : CaseIterable{
        static var allCases: [TV] {
            return [.detail(id: 0), .recommendations(id: 0), .aggregate_credits(id: 0)]
        }
        
        // 여기가 핵심. 구역별로 정하면 될 듯
        // 추가되는 항목을 아래의 리스트에 추가하면 될 듯
        static var contentsInfoAllcases : [TV] {
            return [.aggregate_credits(id: 0), .relatedVideo(id: 0)] //MARK: -
//            return [.aggregate_credits(id: 0)] //MARK: - 관련 동영상은 추후 구현
        }
        
        static var relatedContentsAllcases : [TV] {
            return [.recommendations(id: 0)]
        }
        
        //MARK: - Case
        case detail(id:Int)
        case recommendations(id:Int)
        case aggregate_credits(id:Int)
        case relatedVideo(id:Int) /// 나중에 추가될 경우 ..>!?
        
        var endPoint : URL {
            get {
                switch self {
                case .detail(let id):
                    return URL(string: MediaAPI.baseUrl + "tv/\(id)")!
                case .recommendations(let id):
                    return URL(string: MediaAPI.baseUrl + "tv/\(id)/recommendations")!
                case .aggregate_credits(let id) :
                    return URL(string: MediaAPI.baseUrl + "tv/\(id)/aggregate_credits")!
                case .relatedVideo(id: let id) :
                    return URL(string: MediaAPI.baseUrl + "tv/\(id)/videos")!
                }
            }
        }
        
        var parameter : Parameters {
            switch self {
            case  .detail :
                return ["language":"ko-KR"]
            case .recommendations:
                return ["language":"ko-KR"]
            case .aggregate_credits :
                return ["language":"ko-KR"]
            default :
                return [:]
            }
        }
        
        var indexValue : Int {
            switch self {
            case .detail :
                return 0
            case .recommendations :
                return 1
            case .aggregate_credits :
                return 2
            case .relatedVideo :
                return 99

            }
        }
        
        var titleValue : String {
            switch self {
            case .detail :
                return "detail - None"
            case .recommendations :
                return "비슷한 콘텐츠"
            case .aggregate_credits :
                return "출연"
            case .relatedVideo :
                return "관련 동영상"
            }
        }
        
        var caseValue : String {
            switch self {
            default :
                return String(describing: self)
            }
        }
    }
    
    enum Search : CaseIterable {
        
        static var allCases: [Search] {
            return [.tv, .countries, .search(query: "")]
        }
        
        case countries
        case tv
        case search(query : String)
        
        var endPoint : URL {
            get {
                switch self {
                case .countries:
                    return URL(string: MediaAPI.baseUrl + "configuration/countries")!
                case .tv:
                    return URL(string: MediaAPI.baseUrl + "genre/tv/list")!
                case .search :
                    return URL(string: baseUrl + "search/tv")!
                }
            }
        }
        
        var parameter : Parameters {
            switch self {
            case .search(let query):
                return ["language":"ko-KR","query":query]
            default :
                return ["language":"ko-KR"]
            }
        }
        
        var titleValue : String {
            switch self {
            case .countries :
                return "비디오 국가"
            case .tv :
                return "비디오 장르"
            case .search :
                return "검색"
            }
        }
        
        var indexValue : Int {
            switch self {
            case .countries :
                return 0
            case .tv :
                return 1
            case .search:
                return 2
            }
        }
        
        var caseValue : String {
            switch self {
            default :
                return String(describing: self)
            }
        }
        
        static func searchByIndex(value : Int) -> MediaAPI.Search {
            
            switch value {
            case 0 :
                return .tv
            case 1 :
                return .countries
            case 2:
                return .search(query: "")
            default :
                return .countries
            }
        }
    }
    
    enum SearchDetail
    {
        
//        static var allCases: [SearchDetail] {
//            return [.countries(id: ""), .genere(id: 0), .detail(id: 0)]
//        }
        
        case countries(id:String)
        case genere(id:Int)
        case detail(id:Int)
        
        var endPoint : URL {
            get {
                switch self {
                case .countries,.genere:
                    return URL(string: MediaAPI.baseUrl + "discover/tv")!
                case .detail(let id):
                    return URL(string: MediaAPI.baseUrl + "tv/\(id)")!
                }
            }
        }
        
        
        //TODO: -parameter 추가 필요!!!!!!!!!! ⭕️⭕️⭕️⭕️⭕️⭕️⭕️⭕️⭕️⭕️⭕️
        var parameter : Parameters {
            switch self {
            case .countries(let id) :
                return ["with_origin_country": "\(id)", "sort_by" : "popularity.desc", "language":"ko-KR"]
            case .genere(let id) :
                return ["with_genres" : "\(id)", "sort_by" : "popularity.desc", "language":"ko-KR"]
            default :
                return ["language":"ko-KR"]
            }
        }
        
        var caseValue : String {
            switch self {
            default :
                return String(describing: self)
            }
        }
        
        static func searchByIndex(value : Int) -> MediaAPI.SearchDetail {
            switch value {
            case 0 :
                return .countries(id: "")
            case 1 :
                return .genere(id: 0)
            case 2 :
                return .detail(id: 0)
            default:
                return .countries(id: "")
            }
        }
    }
}

