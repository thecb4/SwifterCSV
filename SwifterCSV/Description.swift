//
//  Description.swift
//  SwifterCSV
//
//  Created by Will Richardson on 11/04/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//

extension CSV: CustomStringConvertible {
    public var description: String {
        let head = header.joined(separator: ",") + "\n"
        
        let delim = String(self.delimiter)
        let cont = rows.map { row in
            header.map { row[$0] ?? "" }.joined(separator: delim)
        }.joined(separator: "\n")
        return head + cont
    }
}