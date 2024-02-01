//
//  TVSeriesModel.swift
//  Media Project
//
//  Created by JinwooLee on 1/31/24.
//

import Foundation

//MARK: - Detail API
struct TVSeriesDetail : Decodable {
    let backdropPath : String
    let genres : [Genres]
    let id : Int
    let originalName : String
    let overview : String
    let tagline : String
    let voteAverage : Double
    let numberOfSeasons : Int
    
    enum CodingKeys : String, CodingKey {
        case genres, id, overview, tagline
        case backdropPath = "backdrop_path"
        case originalName = "original_name"
        case voteAverage = "vote_average"
        case numberOfSeasons = "number_of_seasons"
    }
    
    var mainText : String {
        let genreText : String = genres.map { item in
            return item.name
        }.joined(separator: "-")
        
        return "평균 \(voteAverage)·시즌 \(numberOfSeasons)개·\(genreText)"
    }
    
}

struct Genres : Decodable {
    let id : Int
    let name : String
}

//MARK: - Aggregate Credits API

struct TVSeriesAggregateCredit : Decodable {
    let cast : [Cast]
    let id : Int
}

struct Cast : Decodable {
    let id : Int
    let gender : Int
    let originalName : String
    let profilePath : String?
    let roles : [Role]
    
    enum CodingKeys : String, CodingKey {
        case id, gender, roles
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}

struct Role : Decodable {
    let character : String
    
    var characterConvert : String {
        get {
            return "\(character) 役"
        }
    }
}

//MARK: - Recommendations API
struct TVSeriesRecommendations : Decodable {
    let page : Int
    let results : [Recommendations]
    let totalPages : Int
    
    enum CodingKeys : String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

struct Recommendations : Decodable {
    let id : Int
    let originalName : String
    let overview : String
    let posterPath : String
    
    enum CodingKeys : String, CodingKey {
        case id, overview
        case originalName = "original_name"
        case posterPath = "poster_path"
    }
}
