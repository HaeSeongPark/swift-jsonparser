//
//  JSONParser.swift
//  JSONUnitTest
//
//  Created by rhino Q on 2018. 3. 29..
//  Copyright © 2018년 JK. All rights reserved.
//


import Foundation

struct JSONParser {
    enum Error:Swift.Error{
        case invalidToken
    }
    
    private var json = JSON()
    private var token:Token
    init(_ token:Token) {
        self.token = token
    }
    
    mutating func parse() throws -> JSON {
        
        switch token {
        case .jsonArray(let tokens):
            json.dataCase = .array
          _ = parseJSONArray(tokens)
            
        case .jsonObject(let object):
            json.dataCase = .object
          _ = parseJSONObject(object)
            
        default:
            throw JSONParser.Error.invalidToken
        }
        
        return json
    }
    
    private mutating func parseJSONObject(_ jsonObjects:[String:Token]) -> JSONObjectData {
        for jsonObject in jsonObjects {
            json.objectData[jsonObject.key] = tokenToValue(jsonObject.value)
        }
        return json.objectData
    }
    
    
    private mutating func parseJSONArray(_ tokens:[Token]) -> JSONArrayData {
        json.arrayData = tokens.map { tokenToValue($0)}
        return json.arrayData
    }
    
    private mutating func tokenToValue(_ token:Token) -> Any {
        switch token {
        case .bool(value: let boolData):
            return boolData
        case .number(value: let numberData):
            return numberData
        case .string(value: let stringData):
            return stringData
        case .jsonObject(let jsonObjects):
            return parseJSONObject(jsonObjects)
        case .jsonArray(tokens: let tokens):
            return parseJSONArray(tokens)
        }
    }
}
