//
//  ExportTests.swift
//  SwifterCSV
//
//  Created by Will Richardson on 2/05/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//

import XCTest

class ExportTests: XCTestCase {
    func testDescriptionWithComma() {
        let rows = [
            ["things": "stuff, things"]
        ]
        let csv = CSV(rows: rows)
        XCTAssertEqual(csv.description, "things\n\"stuff, things\"")
        csv.delimiter = "\t"
        XCTAssertEqual(csv.description, "things\nstuff, things")
    }
    
    func testDescriptionWithTab() {
        let rows = [
            ["things": "stuff\tthings"]
        ]
        let csv = CSV(rows: rows, delimiter: "\t")
        XCTAssertEqual(csv.description, "things\n\"stuff\tthings\"")
        csv.delimiter = ","
        XCTAssertEqual(csv.description, "things\nstuff\tthings")
    }
}
