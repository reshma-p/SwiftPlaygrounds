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
