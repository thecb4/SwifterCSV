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
    
    let text: String
    public var delimiter: Character
    
    let loadColumns: Bool
    
    /// Load a CSV file from a string
    ///
    /// - string: string data of the CSV file
    /// - delimiter: character to split row and header fields by (default is ',')
    /// - loadColumns: whether to populate the columns dictionary (default is true)
    public init(string: String, delimiter: Character = comma, loadColumns: Bool = true) {
        self.text = string
        self.delimiter = delimiter
        self.loadColumns = loadColumns
        
        let createHeader: [String] -> () = { head in
            self.header = head
        }
        enumerateAsArray(createHeader, limitTo: 1, startAt: 0)
    }
    
    /// Load an existing row dictionary (for exporting)
    ///
    /// - rows: rows to load, a list of dictionaries
    /// - delimiter: delimiter to use when exporting
    /// - loadColumns: whether to populate the columns dictionary (defaults to false)
    public init(rows: [[String: String]], delimiter: Character = comma, loadColumns: Bool = false) {
        // loadColumns is false by default because 99% of the time this will be
        // used to export data, and so it won't be used.
        self.text = ""
        self.delimiter = delimiter
        self.loadColumns = loadColumns
        
        load(rows: rows)
    }
    
    /// Load columns (for exporting)
    ///
    /// - columns: columns to load, dictionary of string to lists
    /// - delimiter: delimiter to use when exporting
    public init(columns: [String: [String]], delimiter: Character = comma) {
        self.text = ""
        self.delimiter = delimiter
        self.loadColumns = true
        
        load(columns: columns)
    }
}
