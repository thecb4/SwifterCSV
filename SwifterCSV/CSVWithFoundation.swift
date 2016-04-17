//
//  CSVWithFoundation.swift
//  SwifterCSV
//
//  Created by Will Richardson on 15/04/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//

// Only use Foundation on OSX and iOS
#if !os(Linux)
import Foundation

extension CSV {
    /// Load a CSV file
    ///
    /// name: name of the file (will be passed to String(contentsOfFile:encoding:) to load)
    /// delimiter: character to split row and header fields by (default is ',')
    /// encoding: encoding used to read file (default is NSUTF8StringEncoding)
    /// loadColumns: whether to populate the columns dictionary (default is true)
    public convenience init(name: String, delimiter: Character = comma, encoding: NSStringEncoding = NSUTF8StringEncoding, loadColumns: Bool = true) throws {
        let contents = try String(contentsOfFile: name, encoding: encoding)
        
        self.init(string: contents, delimiter: delimiter, loadColumns: loadColumns)
    }
    
    /// Load a CSV file from a URL
    ///
    /// url: url pointing to the file (will be passed to String(contentsOfURL:encoding:) to load)
    /// delimiter: character to split row and header fields by (default is ',')
    /// encoding: encoding used to read file (default is NSUTF8StringEncoding)
    /// loadColumns: whether to populate the columns dictionary (default is true)
    public convenience init(url: NSURL, delimiter: Character = comma, encoding: NSStringEncoding = NSUTF8StringEncoding, loadColumns: Bool = true) throws {
        let contents = try String(contentsOfURL: url, encoding: encoding)
        
        self.init(string: contents, delimiter: delimiter, loadColumns: loadColumns)
    }
    
    /// Turn the CSV data into NSData using a given encoding
    public func dataUsingEncoding(encoding: NSStringEncoding) -> NSData? {
        return description.dataUsingEncoding(encoding)
    }
}
#endif