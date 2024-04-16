//
//  DateExtension.swift
//
//
//  Created by GG on 2024/4/3.
//

import Foundation

extension Date {
    func currentTimeStamp() -> String {
        return String(Int(self.timeIntervalSince1970))
    }
}
