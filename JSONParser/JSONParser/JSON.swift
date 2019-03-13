//
//  JSONData.swift
//  JSONParser
//
//  Created by rhino Q on 2018. 3. 31..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

typealias JSONObjectData = Dictionary<String, Any>
typealias JSONArrayData = [Any]

struct JSON{    
    enum `case` {
        case object
        case array
    }
    
    var dataCase:`case` = .object
    
    var objectData:JSONObjectData = [:]
    var arrayData:JSONArrayData = []
    
    var numberCount:Int  {
        switch dataCase {
        case .object:
            return objectData.filter { $0.value is Double }.count
        case .array:
            return arrayData.filter { $0 is Double }.count
        }
    }
    
    var stringCount:Int {
        switch dataCase {
        case .object:
            return objectData.filter { $0.value is String }.count
        case .array:
            return arrayData.filter { $0 is String }.count
        }
    }
    
    var boolCount:Int {
        switch dataCase {
        case .object:
            return objectData.filter { $0.value is Bool }.count
        case .array:
            return arrayData.filter { $0 is Bool }.count
        }
    }
    
    var arrayCount:Int {
        switch dataCase {
        case .object:
            return objectData.filter { $0.value is [Any] }.count
        case .array:
            return arrayData.filter { $0 is [Any] }.count
        }
    }
    
    var objectCount:Int {
        switch dataCase {
        case .object:
            return objectData.filter { $0.value is [String:Any] }.count
        case .array:
            return arrayData.filter{ $0 is [String:Any] }.count
        }
    }
    
     var parentName:String {
        switch dataCase {
        case .object:
            return "객체"
        case .array:
            return "배열"
        }
    }
    
     var parentCount:Int {
        switch dataCase {
        case .object:
            return objectData.count
        case .array:
            return arrayData.count
        }
    }
    
    func printData() {
        func printDescription() {
            
            print("총 \(parentCount)개의 \(parentName)데이터 중에", terminator:"")
            if numberCount != 0 { print(" 숫자 \(numberCount)개", terminator:"") }
            if stringCount != 0 { print(" 문자열 \(stringCount)개", terminator:"") }
            if boolCount != 0 { print(" 부울 \(boolCount)개", terminator: "") }
            if objectCount != 0 { print(" 객체 \(objectCount)개", terminator:"")}
            if arrayCount != 0 { print(" 배열 \(arrayCount)개", terminator:"")}
            print("가 포함돼 있습니다.")
            print("-----------------------------------")
        }
        
        func printJSONObjectData(_ objectData:JSONObjectData) {
            print("{")
            
            for (index, data) in objectData.enumerated() {
                print("     \(data.key) : ", terminator:"")
                
                if data.value is JSONArrayData {
                    printJSONArrayData(data.value as! JSONArrayData)
                } else {
                    print("\(data.value)", terminator:"")
                }
                
                if index != objectData.count-1 { print(",") }
            }
            
            print("\n}")
        }
        
        func printJSONArrayData(_ arrayData:JSONArrayData) {
            
            print("[", terminator:"")
            for (index, data) in arrayData.enumerated() {
                if data is JSONObjectData {
                    printJSONObjectData(data as! JSONObjectData)
                } else if data is JSONArrayData {
                    printJSONArrayData(data as! JSONArrayData)
                } else {
                    print("\(data)", terminator:"")
                }
                
                if index != arrayData.count-1 { print(",", terminator:" ")}
            }
            print("]", terminator:"")
        }
        
        printDescription()
        switch dataCase {
        case .object:
            printJSONObjectData(objectData)
        case .array:
            printJSONArrayData(arrayData)
        }
    }
}
