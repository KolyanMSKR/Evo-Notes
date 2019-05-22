//
//  String+Extension.swift
//  EvoNote
//
//  Created by asd dsa on 5/22/19.
//  Copyright © 2019 Mykola Korotun. All rights reserved.
//

import Foundation

extension String {
    func truncatePrefix(length: Int) -> String {
        return self.count > length ? self.prefix(length) + String("...") : self
    }
}
