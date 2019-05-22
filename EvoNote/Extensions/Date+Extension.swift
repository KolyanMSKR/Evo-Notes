//
//  Extensions.swift
//  EvoNote
//
//  Created by asd dsa on 5/22/19.
//  Copyright © 2019 Mykola Korotun. All rights reserved.
//

import Foundation

extension Date {
    func toString(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self as Date)
    }
}
