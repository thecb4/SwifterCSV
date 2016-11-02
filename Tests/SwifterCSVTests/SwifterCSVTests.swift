import XCTest
@testable import SwifterCSV

//
//  ExportTests.swift
//  SwifterCSV
//
//  Created by Will Richardson on 2/05/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//

class SwifterCSVTests: XCTestCase {

	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
	}

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

#if os(Linux)
extension SwifterCSVTests {
	static var allTests : [(String, (SwifterCSVTests) -> () throws -> Void)] {
		return [
			("testExample", testExample),
			("testDescriptionWithComma", testDescriptionWithComma),
			("testDescriptionWithComma", testDescriptionWithComma )
		]
	}
}
#endif
