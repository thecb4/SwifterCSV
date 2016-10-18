//
//  StateMachine.swift
//  SwifterCSV
//
//  Created by Will Richardson on 15/04/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//


open class Accumulator {
    private var field: [Character]
    private var fields: [String]

    private let block: ([String]) -> ()
    var count = 0
    private let startAt: Int
    let delimiter: Character

    var hasContent: Bool {
        return field.count > 0 || fields.count > 0
    }

    init(block: @escaping ([String]) -> (), delimiter: Character, startAt: Int = 0) {
        self.block = block
        self.startAt = startAt
        self.delimiter = delimiter
        field = []
        fields = []
    }

    func pushCharacter(_ char: Character) {
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
    case start // start of line or field
    case parsingField // inside a field with no quotes
    case parsingFieldInnerQuotes // escaped quotes in a field
    case parsingQuotes // field with quotes
    case parsingQuotesInner // escaped quotes in a quoted field
    case error(String) // error or something

    func nextState(_ hook: Accumulator, char: Character) -> State {
        switch self {
        case .start:
            return stateFromStart(hook, char)
        case .parsingField:
            return stateFromParsingField(hook, char)
        case .parsingFieldInnerQuotes:
            return stateFromParsingFieldInnerQuotes(hook, char)
        case .parsingQuotes:
            return stateFromParsingQuotes(hook, char)
        case .parsingQuotesInner:
            return stateFromParsingQuotesInner(hook, char)
        default:
            return .error("Unexpected character: \(char)")
        }
    }
}


private func stateFromStart(_ hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        return .parsingQuotes
    } else if char == hook.delimiter {
        hook.pushField()
        return .start
    } else if isNewline(char) {
        hook.pushRow()
        return .start
    } else {
        hook.pushCharacter(char)
        return .parsingField
    }
}

private func stateFromParsingField(_ hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        return .parsingFieldInnerQuotes
    } else if char == hook.delimiter {
        hook.pushField()
        return .start
    } else if isNewline(char) {
        hook.pushRow()
        return .start
    } else {
        hook.pushCharacter(char)
        return .parsingField
    }
}

private func stateFromParsingFieldInnerQuotes(_ hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        hook.pushCharacter(char)
        return .parsingField
    } else {
        return .error("Can't have non-quote here: \(char)")
    }
}

private func stateFromParsingQuotes(_ hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        return .parsingQuotesInner
    } else {
        hook.pushCharacter(char)
        return .parsingQuotes
    }
}

private func stateFromParsingQuotesInner(_ hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        hook.pushCharacter(char)
        return .parsingQuotes
    } else if char == hook.delimiter {
        hook.pushField()
        return .start
    } else if isNewline(char) {
        hook.pushRow()
        return .start
    } else {
        return .error("Can't have non-quote here: \(char)")
    }
}

private func isNewline(_ char: Character) -> Bool {
    return char == "\n" || char == "\r" || char == "\r\n"
}
