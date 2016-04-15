//
//  CSV.swift
//  SwifterCSV
//
//  Created by Naoto Kaneko on 2/18/16.
//  Copyright © 2016 Naoto Kaneko, JavaNut13. All rights reserved.
//

public class CSV {
    static let comma: Character = ","
    
    public var header: [String]!
    var _rows: [[String: String]]? = nil
    var _columns: [String: [String]]? = nil
    
    var text: String
    var delimiter: Character
    
    let loadColumns: Bool
    
    /// Load a CSV file from a string
    ///
    /// string: string data of the CSV file
    /// delimiter: character to split row and header fields by (default is ',')
    /// loadColumns: whether to populate the columns dictionary (default is true)
    public init(string: String, delimiter: Character = comma, loadColumns: Bool = true) {
        self.text = string
        self.delimiter = delimiter
        self.loadColumns = loadColumns
        
        let createHeader: [String] -> () = { head in
            self.header = head
        }
        enumerateAsArray(createHeader, limitTo: 1, startAt: 0)
    }
}
