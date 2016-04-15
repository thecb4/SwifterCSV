//
//  String+Lines.swift
//  SwifterCSV
//
//  Created by Naoto Kaneko on 2/24/16.
//  Copyright © 2016 Naoto Kaneko, JavaNut13. All rights reserved.
//

extension String {
    var firstLine: String {
        var index = startIndex
        let chars = characters
        while index < endIndex && chars[index] != "\r\n" && chars[index] != "\n" && chars[index] != "\r" {
            index = index.successor()
        }
        return substringToIndex(index)
    }
}
