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
        var columns = [String: [String]]()
        // Create a list of headers from all the rows
        for row in rows {
            for key in row.keys {
                if loadColumns {
                    if var arr = columns[key] {
                        arr.append(row[key] ?? "")
                        columns[key] = arr
                    } else {
                        columns[key] = [row[key] ?? ""]
                    }
                }
                header.insert(key)
            }
        }
        self.header = Array(header)
        self._rows = rows
    }
    func load(columns cols: [String: [String]]) {
        self.header = Array(cols.keys)
        var rows = [[String: String]]()
        // Create a list of headers from all the rows
        for (key, values) in cols {
            for (index, val) in values.enumerate() {
                if rows.count <= index {
                    rows.append([key: val])
                } else {
                    rows[index][key] = val
                }
            }
        }
        self._columns = cols
        self._rows = rows
    }
}