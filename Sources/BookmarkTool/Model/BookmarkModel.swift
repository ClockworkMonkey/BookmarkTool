//
//  BookmarkModel.swift
//
//
//  Created by GG on 2024/4/2.
//

import Foundation

// MARK: - BookmarkModel
struct BookmarkModel: Codable {
    var id: String?
    var type: String
    var name, url, iconData, iconURL, description, createDate, updateDate: String?
    var children: [BookmarkModel]
}
