//
//  StateMachine.swift
//  SwifterCSV
//
//  Created by Will Richardson on 15/04/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//


class Accumulator {
    private var field: [Character]
    private var fields: [String]

    private let block: ([String]) -> ()
    var count = 0
    private let startAt: Int
    private let delimiter: Character

    var hasContent: Bool {
        return field.count > 0 || fields.count > 0
    }

    init(block: ([String]) -> (), delimiter: Character, startAt: Int = 0) {
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
    case Start // start of line or field
    case ParsingField // inside a field with no quotes
    case ParsingFieldInnerQuotes // escaped quotes in a field
    case ParsingQuotes // field with quotes
    case ParsingQuotesInner // escaped quotes in a quoted field
    case Error(String) // error or something

    func nextState(_ hook: Accumulator, char: Character) -> State {
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


private func stateFromStart(_ hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        return .ParsingQuotes
    } else if char == hook.delimiter {
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

private func stateFromParsingField(_ hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        return .ParsingFieldInnerQuotes
    } else if char == hook.delimiter {
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

private func stateFromParsingFieldInnerQuotes(_ hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        hook.pushCharacter(char)
        return .ParsingField
    } else {
        return .Error("Can't have non-quote here: \(char)")
    }
}

private func stateFromParsingQuotes(_ hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        return .ParsingQuotesInner
    } else {
        hook.pushCharacter(char)
        return .ParsingQuotes
    }
}

private func stateFromParsingQuotesInner(_ hook: Accumulator, _ char: Character) -> State {
    if char == "\"" {
        hook.pushCharacter(char)
        return .ParsingQuotes
    } else if char == hook.delimiter {
        hook.pushField()
        return .Start
    } else if isNewline(char) {
        hook.pushRow()
        return .Start
    } else {
        return .Error("Can't have non-quote here: \(char)")
    }
}

private func isNewline(_ char: Character) -> Bool {
    return char == "\n" || char == "\r" || char == "\r\n"
}
