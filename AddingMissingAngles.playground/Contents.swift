import UIKit
import XCTest

var str = "==== Add missing paranthese (angles)  ====="

//--- Test Observer which then

class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}
let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)



/*
Problem definition:
 
 Given input => "><<><"
 Add "<" in th beginning and ">" at the end to balance the opening and closing angles.
 
 "><<><" => "<><<><>>"
 
 Solution : Stack problem to handle unmatched paranthese

**/

func solutionAngles(angles: String) -> String {
    
    let anglesArray = Array(angles)
    var anglesStack: [String] = []
    var returnString = angles
    for index in 0...anglesArray.count-1 {
        
        if(anglesArray[index] == ">"){
            //-- First item
            if(anglesStack.isEmpty){
                returnString = "<"+returnString
            } else {
                anglesStack.popLast()
            }
            
        } else if(anglesArray[index] == "<"){
            anglesStack.append(String(anglesArray[index]))
        }
    }
    
    //unmatched open brackets
    let unmatched = anglesStack.count
    print("Unmatched = \(unmatched)")
    if(unmatched > 0){
        for _ in 1...unmatched{
            returnString = returnString + ">"
        }
    }
    return returnString
}

class BalanceAnglesTest: XCTestCase{
    
    func testAddTheMissingAnglesToBalanceIt(){
        
        XCTAssertEqual(solutionAngles(angles: ">"), "<>")
        XCTAssertEqual(solutionAngles(angles: ">"), "<>")
        XCTAssertEqual(solutionAngles(angles: "<>>"), "<<>>")
        
        XCTAssertEqual(solutionAngles(angles: "><<><"), "<><<><>>")
        XCTAssertEqual(solutionAngles(angles: "><<>><"), "<><<>><>")
        
    }
}


BalanceAnglesTest.defaultTestSuite.run()

func isOpeningBracket(_ value: String) -> Bool{
    if (value == "(" || value == "[" || value == "{") {
        return true
    }
    return false
}

func isMatchinTypeBracket(left: String, right: String) -> Bool {
    if (left == "(" && right == ")") || (left == "{" && right == "}") || (left == "[" && right == "]") {
        return true
    }
    
    return false
}
func solutionBalancedParanthese(brackets: String) -> Bool {
    
    let bracketsArray = Array(brackets)
    var bracketsStack: [String] = []
    
    for item in bracketsArray{
        let itemString = String(item)
        if isOpeningBracket(itemString) {
            
            bracketsStack.append(itemString)
        } else {
            let leftbracket = bracketsStack.last
            if(isMatchinTypeBracket(left: leftbracket ?? "", right: itemString)){
                let i = bracketsStack.popLast()
            } else {
                return false
            }
        }
    }
    return bracketsStack.count == 0
}

class BalancedBracketsTest: XCTestCase{
    
    func testBalancedBrackets(){
        
        XCTAssertFalse(solutionBalancedParanthese(brackets: "{{]"))
        XCTAssertTrue(solutionBalancedParanthese(brackets: "{{}}"))
        XCTAssertFalse(solutionBalancedParanthese(brackets: "{{}{[([]{})](){{}}}((({}){()[]}((){})))())}"))
        
        
        
    }
}


BalancedBracketsTest.defaultTestSuite.run()
