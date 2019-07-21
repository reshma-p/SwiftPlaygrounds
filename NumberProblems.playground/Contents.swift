import UIKit
import XCTest

var str = "====Number problems ====="

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

/* PROBLEM : 1
 In this kata you get the start number and the end number of a region and should return the count of all numbers except numbers with a 5 in it. The start and the end number are both inclusive!
 
 Examples:
 
 1,9 -> 1,2,3,4,6,7,8,9 -> Result 8
 4,17 -> 4,6,7,8,9,10,11,12,13,14,16,17 -> Result 12
 The result may contain fives. ;-)
 The start number will always be smaller than the end number. Both numbers can be also negative!
 */


func dontGiveMeFive(_ start: Int, _ end: Int) -> Int {
    var result = (end - start) + 1
    
    for val in start...end{
        if(String(val).contains("5")){
            //-- only ending in 5s
            result -= 1
        }
    }
    return result
}

//-- KATA best practice solution
//func dontGiveMeFive(_ start: Int, _ end: Int) -> Int {
//    return (start...end).filter { !String($0).contains("5") }.count
//}

class DontGiveMeFiveTest: XCTestCase{
    
    func testContainingNoFiveInrange() {
        XCTAssertEqual(dontGiveMeFive(1,4), 4, "1...4 not right result")
    }
    
    func testContainingFivesInRange(){
        XCTAssertEqual(dontGiveMeFive(1,9), 8, "1...9 not right result")
        XCTAssertEqual(dontGiveMeFive(4,17), 12, "4...17 not right result")
        XCTAssertEqual(dontGiveMeFive(5,38), 30, "5...38 not right result")
        
        XCTAssertEqual(dontGiveMeFive(0,38), 35, "0...38 not right result")
    }
    
    func testNegativeRangesWithFive(){
        XCTAssertEqual(dontGiveMeFive(-4,-1), 4, "-4...-1 not right result")
        
        // -4,-3,-2,-1,0,1,2,3,4,6,7,8,9,10
        XCTAssertEqual(dontGiveMeFive(-5,10), 14, "-5...10 not right result")
        
    }
    
    func testFiveIn(){
        // 11 --
        XCTAssertEqual(dontGiveMeFive(50,60), 1, "50...60 not right result")
        
    }
}

DontGiveMeFiveTest.defaultTestSuite.run()

