//
//  File.swift
//  FinalExam
//
//  Created by Irakli Karanadze on 23.05.22.
//

import Foundation

struct TechnicRequest: Decodable {
    let products : [Technic]!
    let total, skip, limit: Int
}

struct Technic: Decodable {
    let id : Int
    let title : String
    let description : String
    var price : Int
    let discountPercentage : Double
    let rating : Double
    let stock : Int
    let brand : String
    let category : String
    let thumbnail : String
    let images : [String]
    
    var count:Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case price = "price"
        case discountPercentage = "discountPercentage"
        case rating = "rating"
        case stock = "stock"
        case brand = "brand"
        case category = "category"
        case thumbnail = "thumbnail"
        case images = "images"
    }
}

