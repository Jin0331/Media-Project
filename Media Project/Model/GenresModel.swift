//
//  GenresModel.swift
//  Media Project
//
//  Created by JinwooLee on 2/5/24.
//

import Foundation

//MARK: - TVGenres
struct Genres : Decodable {
    let genres : [GenresElement]
}

struct GenresElement : Decodable {
    let id : Int
    let name : String
}
