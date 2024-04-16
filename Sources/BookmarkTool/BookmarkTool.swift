//
//  BookmarkTool.swift
//
//
//  Created by GG on 2024/4/3.
//

import Foundation
import SwiftSoup

public struct BookmarkTool {
    func parseBookmarks(htmlString: String) -> [BookmarkModel]? {
        do {
            let document = try SwiftSoup.parse(htmlString)
            guard let body = document.body() else { return nil }
            
            var bookmarkList = [BookmarkModel]()
            var elements = [Element]()
            
            parseElements(elements: body.children(), bookmarks: &bookmarkList, elementList: &elements)
            
            return bookmarkList
        } catch {
            print("Error parsing HTML: ", error.localizedDescription)
            return nil
        }
    }
    
    func parseElements(elements: Elements, bookmarks: inout [BookmarkModel], elementList: inout [Element]) {
        elements.forEach { element in

            // 判断是否被读取循环过
            if elementList.contains(element) {
                return
            } else {
                elementList.append(element)
            }
            
            let tagName = element.tagName().lowercased()
            if tagName == "h3" {
                // 文件夹
                let name = try? element.text()
                let createDate = try? element.attr("add_date")
                let updateDate = try? element.attr("last_modified")
                var bookmark = BookmarkModel(type: "folder", name: name, createDate: createDate, updateDate: updateDate, children: [])
                
                // 寻找文件夹下的书签
                if let siblingElement = try? element.nextElementSibling(), siblingElement.tagName().lowercased() == "dl", siblingElement.childNodeSize() > 0 {
                    parseElements(elements: siblingElement.children(), bookmarks: &bookmark.children, elementList: &elementList)
                }
                bookmarks.append(bookmark)
            } else if tagName == "a" {
                // 书签
                let name = try? element.text()
                let url = try? element.attr("href")
                let createDate = try? element.attr("add_date")
                let iconData = try? element.attr("icon")
                
                let bookmark = BookmarkModel(type: "href", name: name, url: url, iconData: iconData, createDate: createDate, children: [])
                bookmarks.append(bookmark)
            } else {
                // 其他元素，如果存在子元素则继续解析其子元素
                if element.childNodeSize() > 0 {
                    parseElements(elements: element.children(), bookmarks: &bookmarks, elementList: &elementList)
                }
            }
        }
    }

}
