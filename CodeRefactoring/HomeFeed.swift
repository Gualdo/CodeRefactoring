//
//  HomeFeed.swift
//  CodeRefactoring
//
//  Created by De La Cruz, Eduardo on 21/11/2018.
//  Copyright © 2018 De La Cruz, Eduardo. All rights reserved.
//

import Foundation

struct Video: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
}

struct HomeFeed: Decodable {
    let videos: [Video]
}
