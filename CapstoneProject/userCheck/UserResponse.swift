//
//  UserResponse.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/31.
//  Copyright © 2020 이진하. All rights reserved.
//

import ObjectMapper

struct TutorialResponse {
    var code: Int!
    var message: String!
    //var tutorials: [Tutorial?]!
}

extension TutorialResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        //tutorials <- map["result"]
    }
    
}

struct Tutorial {
    var seq: Int!
    var type: String!
    var url: String!
    var content: String!
}

extension Tutorial: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        seq <- map["__v"]
        type <- map["_id"]
        url <- map["url"]
        content <- map["content"]
    }
    
}
