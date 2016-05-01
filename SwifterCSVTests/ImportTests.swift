//
//  ExportTests.swift
//  SwifterCSV
//
//  Created by Will Richardson on 17/04/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//

import XCTest

class ImportTests: XCTestCase {

    func testImportFromRows() {
        let rows = [
            ["thing": "window", "size": "large"],
            ["thing": "laptop", "size": "small"]
        ]
        let csv = CSV(rows: rows)
        XCTAssertEqual(csv.rows, rows)
        let desc = "size,thing\nlarge,window\nsmall,laptop"
        XCTAssertEqual(csv.description, desc)
    }

    func testImportFromColumns() {
        let cols = [
            "thing": ["window", "laptop"],
            "size": ["large", "small"]
        ]
        let csv = CSV(columns: cols)
//        XCTAssertEqual(csv.columns, cols)
        let desc = "size,thing\nlarge,window\nsmall,laptop"
        XCTAssertEqual(csv.description, desc)
    }
}
