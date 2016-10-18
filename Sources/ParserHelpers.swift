
//
//  Parser.swift
//  SwifterCSV
//
//  Created by Will Richardson on 11/04/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//

extension CSV {
    /// List of dictionaries that contains the CSV data
    public var rows: [[String: String]] {
        if _rows == nil {
            parse()
        }
        return _rows!
    }

    /// Parse the file and call a block for each row, passing it as a dictionary
    public func enumerateAsDict(_ block: @escaping ([String: String]) -> ()) {
        let enumeratedHeader = header.enumerated()

        enumerateAsArray { fields in
            var dict = [String: String]()
            for (index, head) in enumeratedHeader {
                dict[head] = index < fields.count ? fields[index] : ""
            }
            block(dict)
        }
    }

    /// Parse the file and call a block on each row, passing it in as a list of fields
    public func enumerateAsArray(_ block: @escaping ([String]) -> ()) {
        self.enumerateAsArray(block, limitTo: nil, startAt: 1)
    }

    private func parse() {
        var rows = [[String: String]]()

        enumerateAsDict { dict in
            rows.append(dict)
        }
        _rows = rows
    }
}
