//
//  DateExtension.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 15/4/22.
//

import Foundation

extension Date {
    func currentTimeInMillis() -> Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
}
