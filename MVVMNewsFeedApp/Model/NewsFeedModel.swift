//
//  NewsFeedModel.swift
//  MVVMNewsFeedApp
//
//  Created by Vinayak Bhor on 19/05/20.
//  Copyright © 2020 Vinayak Bhor. All rights reserved.
//
//Step 1:
import Foundation


struct DataStruct
{
    struct NewsList: Decodable
    {
       let hits:[HitsData]
    }
    struct HitsData:Decodable{
        let title:String?
        let author:String?
        let story_title:String?
    }

    var poster_path: String

    struct CodingKeys: CodingKey {
        var intValue: Int?
        var stringValue: String

        init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
        init?(stringValue: String) { self.stringValue = stringValue }

        static let poster_path = CodingKeys(stringValue: "hits")!
        static func makeKey(poster_path: String) -> CodingKeys {
            return CodingKeys(stringValue: poster_path)!
        }
    }

    init(from coder: Decoder) throws {
        let container = try coder.container(keyedBy: CodingKeys.self)
        self.poster_path = try container.decode(String.self, forKey: .poster_path)
        
    }
}
