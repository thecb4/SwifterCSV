//
//  Parser.swift
//  SwiftCSV
//
//  Created by Will Richardson on 13/04/16.
//  Copyright © 2016 Naoto Kaneko. All rights reserved.
//

extension CSV {
    /// Parse the file and call a block on each row, passing it in as a list of fields
    /// limitTo will limit the result to a certain number of lines
    func enumerateAsArray(block: [String] -> (), limitTo: Int?, startAt: Int = 0) {
        var currentIndex = text.startIndex
        let endIndex = text.endIndex
        
        var state = State.Start
        let doLimit = limitTo != nil
        let accumulate = Accumulator(block: block, delimiter: delimiter, startAt: startAt)
        
        while currentIndex < endIndex {
            if doLimit && accumulate.count >= limitTo! {
                break
            }
            state = state.nextState(accumulate, char: text[currentIndex])
            switch state {
            case .Error(let msg):
                fatalError(msg)
            default:
                break
            }
            currentIndex = currentIndex.successor()
        }
        if accumulate.hasContent || (doLimit && accumulate.count < limitTo!) {
            accumulate.pushRow()
        }
    }
}
