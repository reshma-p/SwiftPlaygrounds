import Foundation
import XCTest

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
    let sum = l.reduce((0,0)) { x,y in
        convertToIrreducibleFraction(addTwofractions(x, y))
    }
    print("sum ofound \(sum)")
    return sum
}

func addTwofractions(_ fraction1 : (Int,Int), _ fraction2 : (Int,Int)) -> (Int,Int){
    print("X => \(fraction1) Y => \(fraction2)")
    // Formula = a/b + c/d => (a*d + c*b)/ (b*d)
    let numerator = (fraction1.0 * fraction2.1) + (fraction1.1 * fraction2.0)
    let denominator = fraction1.1 * fraction2.1
    
    return (numerator,denominator)
}

func convertToIrreducibleFraction(_ fraction1 : (Int,Int)) -> (Int,Int){
    var numerator = fraction1.0
    var denominator = fraction1.1
    
    var upperBound = (numerator < denominator ? numerator : denominator)/2
    print("upperBound : \(upperBound)")
    while upperBound-1 >= 1{
        print("upperBound in loop : \(upperBound)")
        if(numerator % upperBound == 0 && denominator % upperBound == 0 ){
            //-- found the greatest common divisor
            numerator /= upperBound
            denominator /= upperBound
            break;
        }
        upperBound -= 1
    }
    print("numerator : \(numerator) -- denominator : \(denominator)")
    return (numerator,denominator)
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
