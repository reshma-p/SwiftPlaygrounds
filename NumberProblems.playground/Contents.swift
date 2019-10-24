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




/** Problem 3
 You will have a list of rationals in the form
 
 lst = [ [numer_1, denom_1] , ... , [numer_n, denom_n] ]
 or
 
 lst = [ (numer_1, denom_1) , ... , (numer_n, denom_n) ]
 where all numbers are positive integers. You have to produce their sum N / D in an irreducible form: this means that N and D have only 1 as a common divisor.
 
 Example:
 [ [1, 2], [1, 3], [1, 4] ]  -->  [13, 12]
 
 1/2  +  1/3  +  1/4     =      13/12
 */
func sumFracts(_ l: [(Int, Int)]) -> (Int, Int)? {
    
    //-- For each element in the array, add them up
//    let sum = l.reduce((1,1)) { x,y in
//        addTwofractions(x, y)
//    }
    
    var sum = (0,0)
    for rational in l {
        sum = addTwofractions(sum, rational)
    }
    print("sum of ound \(sum)")
    return sum
}

func addTwofractions(_ fraction1 : (Int,Int), _ fraction2 : (Int,Int)) -> (Int,Int){
    // Formula = a/b + c/d => (a*d + c*b)/ (b*d)
    if(fraction2.1 == 0){
        return fraction1
    }else if(fraction1.1 == 0){
        return fraction2
    }
    let numerator = (fraction1.0 * fraction2.1) + (fraction1.1 * fraction2.0)
    let denominator = fraction1.1 * fraction2.1
    
    return convertToIrreducibleFraction((numerator,denominator))
}

func convertToIrreducibleFraction(_ fraction1 : (Int,Int)) -> (Int,Int){
    var numerator = fraction1.0
    var denominator = fraction1.1
    
    var upperBound = (numerator < denominator ? denominator : numerator)/2
    
    while upperBound-1 >= 1{
    
        if(numerator % upperBound == 0 && denominator % upperBound == 0 ){
    
            //-- found the greatest common divisor
            numerator /= upperBound
            denominator /= upperBound
            break;
        }
        upperBound -= 1
    }
   
    return (numerator,denominator)
}

class AddTwoFractionsTest: XCTestCase{
    func assertEqualFractions(_ ans: (Int, Int),_ expected: (Int,Int)) -> Bool{
        if(ans.0 == expected.0 && ans.1 == expected.1){
            return true
        }
        
        return false
    }
    
    func testNonFractions() {
        XCTAssertTrue(assertEqualFractions(addTwofractions((1,2),(1,4)),(3,4)), "Not matching ")
    }
    
}
class ConvertToIrreducibleFractionTest: XCTestCase{
    func testing(_ l: (Int, Int), _ expected: (Int, Int)?) {
        XCTAssert(convertToIrreducibleFraction(l) == expected!, "should return \(expected!)")
    }
    func testExample() {
        testing((2,4),(1,2))
    }
}


class SumOfFractionsTest: XCTestCase{
    
    
    func testing(_ l: [(Int, Int)], _ expected: (Int, Int)?) {
        XCTAssert(sumFracts(l)! == expected!, "should return \(expected!)")
    }
    func testingNil(_ l: [(Int, Int)]) {
        XCTAssertTrue(sumFracts(l) == nil, "Should return nil")
    }
    
    func testExample() {
        testing([(1, 2), (1, 3), (1, 4)], (13, 12))
        testing([(1, 3), (5, 3)], (2, 1))
        testingNil([])
        testing([(1, 8), (1, 9)], (17, 72))
    }
    
}






/// Problem 4: You are given an array (which will have a length of at least 3, but could be very large) containing integers. The array is either entirely comprised of odd integers or entirely comprised of even integers except for a single integer N. Write a method that takes the array as an argument and returns this "outlier" N.

/// Examples
/// [2, 4, 0, 100, 4, 11, 2602, 36]
/// Should return: 11 (the only odd number)

/// [160, 3, 1719, 19, 11, 13, -21]
/// Should return: 160 (the only even number)

func findOutlier(_ array: [Int]) -> Int {
    
    var evenCount = 0
    
    //-- Checking just 3 first elements to make a decision if its odd or evens
    for index in 0..<3{
        if(array[index].isEven()){
            evenCount += 1
        }
    }
    
    
    if(evenCount >= 2){
        let oddArray = array.filter { (val) -> Bool in
            return !val.isEven()
        }
        return oddArray[0]
    }else{
        let evenArray = array.filter { (val) -> Bool in
            return val.isEven()
        }
        return evenArray[0]
    }
    
}

extension Int {
    func isEven() -> Bool{
        if self % 2 == 0{
            return true
        }
        
        return false
    }
}

class FindOutlierTest: XCTestCase{

    
    func testOddOutlierInSmallArray() {
        XCTAssertEqual(findOutlier([2,3,4]),3, "Not matching")
        XCTAssertEqual(findOutlier([1, 33, 10053359313, 2, 1, 1, 1, 1, 1, 1, -3, 9]), 2)
        XCTAssertEqual(findOutlier([8, 80, 14, 2, 20, 0, 21, 80]), 21)
    }
    
}


//--- TEST runs
//-- Problem 1 tests
//DontGiveMeFiveTest.defaultTestSuite.run()
////
//////-- Problem 2 tests
//GetDivisorTest.defaultTestSuite.run()
//CheckSquareRootTest.defaultTestSuite.run()
//ListSquareTest.defaultTestSuite.run()
//
////-- Problem 3 tests
AddTwoFractionsTest.defaultTestSuite.run()
ConvertToIrreducibleFractionTest.defaultTestSuite.run()
SumOfFractionsTest.defaultTestSuite.run()


//-- Problem 4 tests
//FindOutlierTest.defaultTestSuite.run()


//
//func fibonacci(_ until: Int){
////    if n <= 2 {
////        return 1
////    } else {
////        return fibonacci(n - 1) + fibonacci(n - 2)
////    }
//    var fibonacciSeries: [Double] = [0,1]
//
//    for index in 2..<until{
//        fibonacciSeries.append(fibonacciSeries[index-1] + fibonacciSeries[index-2])
//    }
//
//    print(fibonacciSeries)
//}
//fibonacci(400)
//print(fibonacci(10))
