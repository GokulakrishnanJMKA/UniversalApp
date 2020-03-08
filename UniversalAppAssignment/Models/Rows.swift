//
//  Rows.swift
//  UniversalAppAssignment
//
//  Created by apple on 06/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

struct RowList: Decodable {
    let title: String
    let rows: [Row]
}

struct Row: Decodable {    
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
