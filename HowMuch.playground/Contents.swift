import UIKit
import XCTest

var str = "==== How much  problems ====="

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
 Problem definition: https://www.codewars.com/kata/55b4d87a3766d9873a0000d4/swift
 
 I always thought that my old friend John was rather richer than he looked, but I never knew exactly how much money he actually had. One day (as I was plying him with questions) he said:

 "Imagine I have between m and n Zloty..." (or did he say Quetzal? I can't remember!)
 "If I were to buy 9 cars costing c each, I'd only have 1 Zloty (or was it Meticals?) left."
 "And if I were to buy 7 boats at b each, I'd only have 2 Ringglets (or was it Zloty?) left."
 Could you tell me in each possible case:

 how much money f he could possibly have ?
 the cost c of a car?
 the cost b of a boat?
 So, I will have a better idea about his fortune. Note that if m-n is big enough, you might have a lot of possible answers.

 Each answer should be given as ["M: f", "B: b", "C: c"] and all the answers as [ ["M: f", "B: b", "C: c"], ... ]. "M" stands for money, "B" for boats, "C" for cars.

 Note: m, n, f, b, c are positive integers, where 0 <= m <= n or m >= n >= 0. m and n are inclusive.

 Examples:
 howmuch(1, 100)      => [["M: 37", "B: 5", "C: 4"], ["M: 100", "B: 14", "C: 11"]]
 howmuch(1000, 1100)  => [["M: 1045", "B: 149", "C: 116"]]
 howmuch(10000, 9950) => [["M: 9991", "B: 1427", "C: 1110"]]
 howmuch(0, 200)      => [["M: 37", "B: 5", "C: 4"], ["M: 100", "B: 14", "C: 11"], ["M: 163", "B: 23", "C: 18"]]
 Explanation of the results for howmuch(1, 100):

 In the first answer his possible fortune is 37:
 so he can buy 7 boats each worth 5: 37 - 7 * 5 = 2
 or he can buy 9 cars worth 4 each: 37 - 9 * 4 = 1
 The second possible answer is 100:
 he can buy 7 boats each worth 14: 100 - 7 * 14 = 2
 or he can buy 9 cars worth 11: 100 - 9 * 11 = 1
 
 **/

func howMuch(_ m: Int, _ n: Int) -> [(String, String, String)] {
    
    var costArray : [(String, String, String)] = []
    let range = min(m,n) ... max(m,n)
    
    for val in range {
        if ((val - 2) % 7 == 0 && (val - 1) % 9 == 0) {
            let b = (val - 2) / 7
            let c = (val - 1) / 9
            //found match
            costArray.append(("M: \(val)", "B: \(b)", "C: \(c)"))
        }
    }
    return costArray
}

func testing(_ m: Int, _ n: Int, _ expected: [(String, String, String)]) {
    let ans  = howMuch(m, n)
    if ans.count == expected.count {
        for i in 0..<expected.count {
            XCTAssertTrue(howMuch(m, n)[i] == expected[i], "Actual and Expected don't have same value at index \(i) -> expected \(expected[i])")
        }
    }
    else {XCTAssertEqual(ans.count, expected.count, "Actual and Expected don't have same length")}
}

class HowMuchCostTest: XCTestCase{
    
    func testMnNisSame(){
        testing(0,0,[])
        testing(37,37,[("M: 37", "B: 5", "C: 4")])
        testing(1,100,[("M: 37", "B: 5", "C: 4"),("M: 100", "B: 14", "C: 11")])
        testing(0,200,[("M: 37", "B: 5", "C: 4"),("M: 100", "B: 14", "C: 11"),("M: 163", "B: 23", "C: 18")])
    }
}


HowMuchCostTest.defaultTestSuite.run()
