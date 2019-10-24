import UIKit
import XCTest

var str = "Hello, playground"

//--- Test Observer

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


/**
 Problem definition from codewar kata : https://www.codewars.com/kata/5870db16056584eab0000006/train/swift
 
 Create your own mechanical dartboard that gives back your score based on the coordinates of your dart.
 
 Task:
 
 Use the scoring rules for a standard dartboard:
 
 Finish method:
 func getScore(dart: (x: Double, y: Double)) -> String
 The coordinates are `(x, y)` are always relative to the center of the board (0, 0). The unit is millimeters. If you throw your dart 5 centimeters to the left and 3 centimeters below, it is written as:
 var score = Dartboard.getScore(dart: (x: -50, y: -30))
 
 Possible scores are:
 Outside of the board: `"X"`
 Bull's eye: `"DB"`
 Bull: `"SB"`
 A single number, example: `"10"`
 A triple number: `"T10"`
 A double number: `"D10"`
 
 A throw that ends exactly on the border of two sections results in a bounce out. You can ignore this because all the given coordinates of the tests are within the sections.
 
 The diameters of the circles on the dartboard are:
 Bull's eye: `12.70 mm`
 Bull: `31.8 mm`
 Triple ring inner circle: `198 mm`
 Triple ring outer circle: `214 mm`
 Double ring inner circle: `324 mm`
 Double ring outer circle: `340 mm`
 */

    func getDartScore(dart: (x: Double, y: Double)) -> String {
        
        if(hypotenuse(dart.x, dart.y) <= DartScoreCard.BullsEye.radius){
            return DartScoreCard.BullsEye.score
        }
        return ""
    }


enum DartScoreCard:String {
    
    case BullsEye
    case Bull
    
    
    var score: String{
        switch(self){
            case .BullsEye :
               return "DB"
            case .Bull :
               return "SB"
        }
    }
    
    
    var diameter: Double{
        switch(self){
        case .BullsEye :
            return 12.7
        case .Bull :
            return 31.8
        }
    }
    
    var radius: Double{
        return diameter/2
    }
}
func hypotenuse(_ a: Double, _ b: Double) -> Double{
    return (a * a + b * b).squareRoot()
}

class DartboardTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func testInsideBullsEye() {
        
        XCTAssertEqual(getDartScore(dart: (x: -5, y: -3)),"DB","Didn't match the bull's eye score")
        XCTAssertEqual(getDartScore(dart: (x: 5, y: 3)),"DB","Didn't match the bull's eye score")
        XCTAssertEqual(getDartScore(dart: (x: 3, y: 5)),"DB","Didn't match the bull's eye score")
        XCTAssertEqual(getDartScore(dart: (x: 4, y: 4)),"DB","Didn't match the bull's eye score")
    }
    
    func testInsideBull() {
        
        XCTAssertEqual(getDartScore(dart: (x:10, y: 10)),"SB","Didn't match the bull's score")
    }
}


DartboardTests.defaultTestSuite.run()


