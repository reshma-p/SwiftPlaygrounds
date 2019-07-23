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


/* Problem 2
 
 Divisors of 42 are : 1, 2, 3, 6, 7, 14, 21, 42. These divisors squared are: 1, 4, 9, 36, 49, 196, 441, 1764. The sum of the squared divisors is 2500 which is 50 * 50, a square!
 
 Given two integers m, n (1 <= m <= n) we want to find all integers between m and n whose sum of squared divisors is itself a square. 42 is such a number.
 
 The result will be an array of arrays or of tuples (in C an array of Pair) or a string, each subarray having two elements, first the number whose squared divisors is a square and then the sum of the squared divisors.
 
 #Examples:
 
 list_squared(1, 250) --> [[1, 1], [42, 2500], [246, 84100]]
 list_squared(42, 250) --> [[42, 2500], [246, 84100]]
 The form of the examples may change according to the language, see Example Tests: for more details.
 
 Note
 
 In Fortran - as in any other language - the returned string is not permitted to contain any redundant trailing whitespace: you can use dynamically allocated character strings.
 
 */


func listSquared(_ m: Int, _ n: Int) -> [(Int,Int)] {

    var squaredList : [(Int,Int)] = []
    if(m <= n){
        for value in m...n{
            //--- get divisors for "value"
            let sum = getDivsors(value).reduce(0) { x, y in
                x + (y*y)
            }
            if(value == 1){
              print("SUM : \(sum)")
            }
            if(checkSquare(sum)){
                if(value == 1){
                    print("SUM : \(sum)")
                }
                squaredList.append((value,sum))
            }
        }
    }
    return squaredList
}

func checkSquare(_ square: Int) -> Bool{
    let squareRoot = sqrt(Double(square))
    
    if(squareRoot - floor(squareRoot) == 0){
        return true
    }
    return false
}

//-- Gets the list of divisors for given number
func getDivsors(_ number: Int) -> [Int]{
    var divisors : [Int] = [number]
    
    if(number == 1 ){
        return [1]
    }else{
        for value in 1...number/2{
            if number % value == 0{
                divisors.append(value)
            }
        }
    }
    
    return divisors.sorted(by: <)
}


class CheckSquareRootTest: XCTestCase{
    
    func testPerfectSquare() {
        XCTAssertEqual(checkSquare(144),true,"Expected perfect square")
    }
    
    func testNotPerfectSquare(){
        XCTAssertEqual(checkSquare(141),false,"Expected no square")
    }
    
}

class GetDivisorTest: XCTestCase{
    
    func testDivisorPrimes() {
        XCTAssertEqual(getDivsors(1),[1],"Not matching ")
        XCTAssertEqual(getDivsors(3),[1,3],"Not matching ")
    }
    
    func testDivisorsNonPrime(){
        //-- 300  => 1 2  3  5  6  10  30  50   60  100  150  300
        XCTAssertEqual(getDivsors(33),[1, 3, 11,33],"Not matching ")
        XCTAssertEqual(getDivsors(300),[1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 25, 30, 50, 60, 75, 100, 150, 300],"Not matching ")
        XCTAssertEqual(getDivsors(42),[1, 2, 3, 6, 7, 14, 21, 42],"Not matching ")
        XCTAssertEqual(getDivsors(50),[1, 2, 5, 10, 25, 50],"Not matching ")
    }
    
}
class ListSquareTest: XCTestCase{
    
    func testing(_ m: Int, _ n: Int, _ expected: [(Int, Int)]) {
        let ans  = listSquared(m, n)
        if ans.count == expected.count {
            for i in 0..<expected.count {
                XCTAssertTrue(ans[i] == expected[i], "Actual and Expected don't have same value at index \(i) -> expected \(expected[i])")
            }
        }
        else {XCTAssertEqual(ans.count, expected.count, "Actual and Expected don't have same length \(ans)--- \(expected)")}
    }
    
    func testExample() {
        testing(1, 250, [(1, 1), (42, 2500), (246, 84100)])
        testing(42, 250, [(42, 2500), (246, 84100)])
        testing(250, 500, [(287, 84100)])
        testing(300, 600, [])
    }
    
}




//--- TEST runs

DontGiveMeFiveTest.defaultTestSuite.run()
GetDivisorTest.defaultTestSuite.run()
CheckSquareRootTest.defaultTestSuite.run()
ListSquareTest.defaultTestSuite.run()

