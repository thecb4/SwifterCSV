//
//  Description.swift
//  SwifterCSV
//
//  Created by Will Richardson on 11/04/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//

// https://www.hackingwithswift.com/swift3

extension CSV: CustomStringConvertible {
    public var description: String {
        let delim = String(self.delimiter)
        let head = header.joined(separator: delim) + "\n"

        let cont = rows.map { row in
            header.map { escape(delim, field: row[$0] ?? "") }.joined(separator: delim)
        }.joined(separator: "\n")
        return head + cont
    }
}

private func escape(_ delimiter: String, field: String) -> String {
    //let quoted = field.stringByReplacingOccurrencesOfString("\"", withString: "\"\"")
    let quoted = field.replacingOccurrences(of: "\"", with: "\"\"")
    // field.containsString(delimiter)
    if field.contains(delimiter) {
        return "\"\(quoted)\""
    } else {
        return quoted
    }
}
