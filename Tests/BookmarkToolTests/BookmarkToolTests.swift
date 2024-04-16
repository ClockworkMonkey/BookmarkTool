import XCTest
import SwiftSoup

@testable import BookmarkTool

final class BookmarkToolTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
        
        if let fileURL = Bundle.module.url(forResource: "Chrome", withExtension: "html", subdirectory: "Resources") {
            do {
                let htmlString = try String(contentsOf: fileURL)
                if let bookmarks = parseBookmarks(htmlString: htmlString) {
                    // 将解析结果转换为 JSON 格式
                    print(bookmarks)
                }
            } catch {
                print("Error")
            }
        }
    }
}
