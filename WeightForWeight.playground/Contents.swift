import UIKit
import XCTest

print("====== Weight for weight Kata ========")
/* Problem definition
 Source : https://www.codewars.com/kata/55c6126177c9441a570000cc/train/swift
 My friend John and I are members of the "Fat to Fit Club (FFC)". John is worried because each month a list with the weights of members is published and each month he is the last on the list which means he is the heaviest.

 I am the one who establishes the list so I told him: "Don't worry any more, I will modify the order of the list". It was decided to attribute a "weight" to numbers. The weight of a number will be from now on the sum of its digits.

 For example 99 will have "weight" 18, 100 will have "weight" 1 so in the list 100 will come before 99. Given a string with the weights of FFC members in normal order can you give this string ordered by "weights" of these numbers?

 Example:
 "56 65 74 100 99 68 86 180 90" ordered by numbers weights becomes: "100 180 90 56 65 74 68 86 99"

 When two numbers have the same "weight", let us class them as if they were strings (alphabetical ordering) and not numbers: 100 is before 180 because its "weight" (1) is less than the one of 180 (9) and 180 is before 90 since, having the same "weight" (9), it comes before as a string.

 All numbers in the list are positive numbers and the list can be empty.

 Notes
 it may happen that the input string have leading, trailing whitespaces and more than a unique whitespace between two consecutive numbers
 Don't modify the input
 For C: The result is freed.
 
 */


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



func orderWeight(_ s: String) -> String {
    var weighTArray = s.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    
    weighTArray.sort { (a, b) in
        let weightA = calculateWeight(String(a))
        let weightB = calculateWeight(String(b))
        
        return weightA == weightB ? a < b : weightA < weightB
    }
    return  weighTArray.joined(separator: " ")
}

func calculateWeight(_ numberString: String) -> Int{
    guard let _ = Int(numberString) else {
        return -1
    }
    return numberString.reduce(0) { (x, y) -> Int in
        return Int(x) + (Int(String(y)) ?? 0)
    }
}
class WeightOrderingTest: XCTestCase{

    func testEmptyString(){
        let actual = orderWeight("")
        XCTAssertEqual(actual, "", "The empty string is not present")
    }
    
    func testTrimingSpacesAtEndsOfString(){
        let actual1 = orderWeight(" 24 24 24")
        let actual2 = orderWeight(" 32 32 32 ")
        XCTAssertEqual(actual1, "24 24 24", "The empty string is not present")
        XCTAssertEqual(actual2, "32 32 32", "The empty string is not present")
    }
    
    func testOrderTheNumbers(){
        let actual1 = orderWeight(" 21 32 90")
        XCTAssertEqual(actual1, "21 32 90", "The empty string is not present")
    }
    
    func testOrderTheNumbersByWeights(){
       let actual1 = orderWeight(" 24 31 90")
       XCTAssertEqual(actual1, "31 24 90", "The empty string is not present")
    }
    
    func testOrderByWeightsAndString(){
        let actual1 = orderWeight(" 180 90 10")
        let actual2 = orderWeight("56 65 74 100 99 68 86 180 90")
        XCTAssertEqual(actual1, "10 180 90", "The empty string is not present")
        XCTAssertEqual(actual2, "100 180 90 56 65 74 68 86 99", "The empty string is not present")
    }
}

WeightOrderingTest.defaultTestSuite.run()
