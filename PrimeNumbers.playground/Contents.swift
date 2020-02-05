import UIKit
import XCTest



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
 Problem definition
 =====================
 A prime number (or a prime) is a natural number greater than 1 that has no positive divisors other than 1 and itself.

 A more detailed description of prime numbers can be found at: http://en.wikipedia.org/wiki/Prime_number

 The Problem
 You will need to create logic for the following two functions: isPrime(number) and getPrimes(start, finish)

 isPrime(number)
 Should return boolean true if prime, otherwise false

 getPrimes(start, finish)
 Should return a unique, sorted array of all primes in the range [start, finish] (i.e. both numbers inclusive). Note that this range can go both ways - e.g. getPrimes(10, 1) should return all primes from 1 to 10 both inclusive.

 Sample Input:
 isPrime(number):

 isPrime(0); // === false
 isPrime(1); // === false
 isPrime(2); // === true
 isPrime(3); // === true
 isPrime(4); // === false
 isPrime(5); // === true
 getPrimes(start, finish):

 getPrimes(0, 0); // === []
 getPrimes(0, 30); // === [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
 getPrimes(30, 0); // === [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
 */

func isPrime(_ number: Int) -> Bool{
    
    var numOfDivisors = 1
    
    if(number > 1){
        for value in 1...number/2{
            if number % value == 0{
                numOfDivisors += 1
            }
            if numOfDivisors > 2 {
                break
            }
        }
    }
    
    return numOfDivisors == 2 ? true : false
}


class PrimeTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
  
    func testisPrimeNumbersLessThanEqualTo1(){
        XCTAssertFalse(isPrime(0),"0 is not prime")
        XCTAssertFalse(isPrime(1),"1 is not prime")
    }
    
    func testisPrimeNumbersForlessThan10(){
        XCTAssertTrue(isPrime(2),"2 is a prime")
        XCTAssertFalse(isPrime(9),"9 is not a prime")
   }
    
    func testisPrimeNumbersForHigerNumbers(){
         XCTAssertFalse(isPrime(2232),"2232 is not a prime")
         XCTAssertTrue(isPrime(2237),"2237 is a prime")
    }
}
PrimeTests.defaultTestSuite.run()
