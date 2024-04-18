//
//  BookmarkModel.swift
//
//
//  Created by GG on 2024/4/2.
//

import Foundation

// MARK: - BookmarkModel
public struct BookmarkModel: Codable {
    public var id: String?
    public var type: String
    public var name, url, iconData, iconURL, description, createDate, updateDate: String?
    public var children: [BookmarkModel]
}
