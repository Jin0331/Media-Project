//
//  ConfigurationModel.swift
//  Media Project
//
//  Created by JinwooLee on 2/5/24.
//

import Foundation


struct CountriesElement : Decodable {
    let iso_3166_1, englishName, nativeName : String
    
    enum CodingKeys : String, CodingKey {
        case iso_3166_1
        case englishName = "english_name"
        case nativeName = "native_name"
    }
}

typealias Countries = [CountriesElement]
