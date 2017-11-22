//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

var inputValue: String = ""
let grammarChecker: GrammarChecker = GrammarChecker()
// 입력
let inputView: InputView = InputView.init(grammarChecker: grammarChecker)
do {
    inputValue = try inputView.readInput()
    // 분석
    let jsonAnalyser = JSONAnalyser.init(grammarChecker: grammarChecker)
    let jsonType = jsonAnalyser.getJSONType(inputValue: inputValue)
    // JSON 형식
    var jsonPainter = JSONPainter()
    jsonPainter.paintJSON(jsonType: jsonType)
    // 출력
    let outputView = OutputView.init(jsonType: jsonType)
    outputView.printResult(jsonPainter: jsonPainter)
} catch InputView.InputError.notJSONPattern {
    print("지원하지 않는 형식을 포함하고 있습니다.")
} catch {
    print("입력이 올바르지 않습니다.")
}
