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
        let accumulate = Accumulator(block: block, startAt: startAt)
        
        while currentIndex < endIndex {
            state = state.nextState(accumulate, char: text[currentIndex])
            if doLimit && accumulate.count >= limitTo! {
                break
            }
            currentIndex = currentIndex.successor()
        }
        if !isNewline(text[currentIndex.predecessor()]) || (doLimit && accumulate.count < limitTo!) {
            state.nextState(accumulate, char: "\n")
        }
    }
}

class Accumulator {
    var field: [Character]
    var fields: [String]
    
    let block: ([String]) -> ()
    var count = 0
    let startAt: Int
    
    init(block: ([String]) -> (), startAt: Int = 0) {
        self.block = block
        field = []
        fields = []
        self.startAt = startAt
    }
    
    func pushCharacter(char: Character) {
        field.append(char)
    }
    func pushField() {
        fields.append(String(field))
        field = []
    }
    func pushRow() {
        fields.append(String(field))
        if count >= startAt {
            block(fields)
        }
        count += 1
        fields = [String]()
        field = [Character]()
    }
}

enum State {
    case Start // start of line or field
    case ParsingField // inside a field with no quotes
    case ParsingFieldInnerQuotes // escaped quotes in a field
    case ParsingQuotes // field with quotes
    case ParsingQuotesInner // escaped quotes in a quoted field
    case Error(String) // error or something
    
    func nextState(hook: Accumulator, char: Character) -> State {
        switch self {
        case Start:
            return stateFromStart(hook, char)
        case .ParsingField:
            return stateFromParsingField(hook, char)
        case .ParsingFieldInnerQuotes:
            return stateFromParsingFieldInnerQuotes(hook, char)
        case .ParsingQuotes:
            return stateFromParsingQuotes(hook, char)
        case .ParsingQuotesInner:
            return stateFromParsingQuotesInner(hook, char)
        default:
            return .Error("Unexpected character: \(char)")
        }
    }
}


private func stateFromStart(hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        return .ParsingQuotes
    } else if char == "," {//self.delimiter {
        hook.pushField()
        return .Start
    } else if isNewline(char) {
        hook.pushRow()
        return .Start
    } else {
        hook.pushCharacter(char)
        return .ParsingField
    }
}

private func stateFromParsingField(hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        return .ParsingFieldInnerQuotes
    } else if char == "," {//self.delimiter {
        hook.pushField()
        return .Start
    } else if isNewline(char) {
        hook.pushRow()
        return .Start
    } else {
        hook.pushCharacter(char)
        return .ParsingField
    }
}

private func stateFromParsingFieldInnerQuotes(hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        hook.pushCharacter(char)
        return .ParsingField
    } else {
        return .Error("Can't have non-quote here: \(char)")
    }
}

private func stateFromParsingQuotes(hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        return .ParsingQuotesInner
    } else {
        hook.pushCharacter(char)
        return .ParsingQuotes
    }
}

private func stateFromParsingQuotesInner(hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        hook.pushCharacter(char)
        return .ParsingQuotes
    } else if char == "," {// self.delimiter {
        hook.pushField()
        return .Start
    } else if isNewline(char) {
        hook.pushRow()
        return .Start
    } else {
        return .Error("Can't have non-quote here: \(char)")
    }
}

private func isNewline(char: Character) -> Bool {
    return char == "\n" || char == "\r\n"
}









