import UIKit
import XCTest
var str = "Hello, playground"


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





// --- Reverses the digits of the integer passed
func reverseDigits(number: Int) -> [Int]{
    var digits:[Int] = []
    var number = number //-- All arguments are consts
    if(number == 0 ){
        return [0]
    }
    while number > 0{
        digits.append(number%10)
        number = number/10
    }
    return digits
}


class RevereseDigitsTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    func testDigitGeneration() {
        XCTAssertEqual(reverseDigits(number: 0), [0], "Not matching numbers ")
        XCTAssertEqual(reverseDigits(number: 1), [1], "Not matching numbers ")
        XCTAssertEqual(reverseDigits(number: 44), [4,4], "Not matching numbers ")
        XCTAssertEqual(reverseDigits(number: 21445), [5, 4, 4, 1, 2], "Not matching numbers ")
    }
}



func convertToDigits(number: Int) -> [Int]{
    return reverseDigits(number: number).reversed()
}

class ConvertToDigitsTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    func testDigitGeneration() {
        XCTAssertEqual(convertToDigits(number: 0), [0], "Not matching numbers ")
        XCTAssertEqual(convertToDigits(number: 1), [1], "Not matching numbers ")
        XCTAssertEqual(convertToDigits(number: 44), [4,4], "Not matching numbers ")
        XCTAssertEqual(convertToDigits(number: 21445), [2,1,4,4,5], "Not matching numbers ")
    }
}

/*
 
 Your task is to make a function that can take any non-negative integer as a argument and return it with its digits in descending order.
 Essentially, rearrange the digits to create the highest possible number.
 
 
 Examples:
 Input: 21445 Output: 54421
 
 Input: 145263 Output: 654321
 
 Input: 1254859723 Output: 9875543221
 
 */

func orderInDescending(number: Int) -> Int{
    let digitsOrdered : [Int] = convertToDigits(number: number).sorted(by: >)
    //--TODO: Need to handle optional from this one
    let number = Int(digitsOrdered.map({String($0)}).joined(separator: "")) ?? number
    return number
}

class DescendingOrderTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    func testSameDigits() {
        XCTAssertEqual(orderInDescending(number: 1), 1, "Not matching numbers ")
        XCTAssertEqual(orderInDescending(number: 44), 44, "Not matching numbers ")
        XCTAssertEqual(orderInDescending(number: 555), 555, "Not matching numbers ")
        XCTAssertEqual(orderInDescending(number: 0), 0, "Not matching numbers ")
    }

    func testOrderedFor2Digits() {
        XCTAssertEqual(orderInDescending(number: 21), 21, "Not matching numbers ")
        XCTAssertEqual(orderInDescending(number: 45), 54, "Not matching numbers ")
        XCTAssertEqual(orderInDescending(number: 15), 51, "Not matching numbers ")
    }
    
    func testOrderedMoreDigits() {
        XCTAssertEqual(orderInDescending(number: 21445), 54421, "Not matching numbers ")
        XCTAssertEqual(orderInDescending(number: 145263), 654321, "Not matching numbers ")
        XCTAssertEqual(orderInDescending(number: 1254859723), 9875543221, "Not matching numbers ")
    }
}

RevereseDigitsTests.defaultTestSuite.run()
ConvertToDigitsTests.defaultTestSuite.run()
DescendingOrderTests.defaultTestSuite.run()





func descendingOrder(of number: Int) -> Int {
    let sortedCharacters = String(number).sorted { $0 > $1 }
    return Int(String(sortedCharacters))!
}
