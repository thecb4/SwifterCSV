//
//  Import.swift
//  SwifterCSV
//
//  Created by Will Richardson on 17/04/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//

extension CSV {
    func load(rows rows: [[String: String]]) {
        var header: Set<String> = []
        // Create a list of headers from all the rows
        for row in rows {
            for key in row.keys {
                header.insert(key)
            }
        }
        self.header = Array(header)
        self._rows = rows
    }
    
    func load(header header: [String], rows: [[String]]) {
        self.header = header
        var rowsDict = [[String: String]]()
        for row in rows {
            var rowDict = [String: String]()
            for (idx, head) in header.enumerate() {
                rowDict[head] = idx < row.count ? row[idx] : ""
            }
            rowsDict.append(rowDict)
        }
        self._rows = rowsDict
    }
}