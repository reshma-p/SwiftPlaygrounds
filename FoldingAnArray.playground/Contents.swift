import UIKit
import XCTest

print("====== Folding Array Kata ========")



/*  KATA description
 
 #Fold an array
 
 In this kata you have to write a method that folds a given array of integers by the middle x-times.
 
 An example says more than thousand words:
 
 Fold 1-times:
 [1,2,3,4,5] -> [6,6,3]
 
 A little visualization (NOT for the algorithm but for the idea of folding):
 
 Step 1         Step 2        Step 3       Step 4       Step5
                      5/           5|         5\
                     4/            4|          4\
 1 2 3 4 5      1 2 3/         1 2 3|       1 2 3\       6 6 3
 ----*----      ----*          ----*        ----*        ----*
 
 
 Fold 2-times:
 [1,2,3,4,5] -> [9,6]
 As you see, if the count of numbers is odd, the middle number will stay. Otherwise the fold-point is between the middle-numbers, so all numbers would be added in a way.
 
 The array will always contain numbers and will never be null. The parameter runs will always be a positive integer greater than 0 and says how many runs of folding your method has to do.
 
 If an array with one element is folded, it stays as the same array.
 
 The input array should not be modified!
 
 Have fun coding it and please don't forget to vote and rank this kata! :-)
 
 I have created other katas. Have a look if you like coding and challenges.
 */



    func foldArray(_ arr: [Int], times: Int) -> [Int] {
        if times == 0 { return arr }
        let tail = arr.suffix(arr.count/2).reversed() + [0]
        let head = arr.prefix((arr.count+1)/2)
        let arrBack = zip(head, tail).compactMap{ $0.0 + $0.1 }
        return foldArray(arrBack, times: times-1)
    }


class FoldingArrayTest: XCTestCase{
    
    func testSingleElementNTimes(){
        XCTAssertEqual(foldArray( [4],times: 0), [4],"Not matching")
        XCTAssertEqual(foldArray( [4],times: 2), [4],"Not matching")
        XCTAssertEqual(foldArray( [4],times: 100), [4],"Not matching")
    }
    
    func testEvenLengthArray1Times(){
        XCTAssertEqual(foldArray( [4,2],times: 1), [6],"Not matching")
        XCTAssertEqual(foldArray( [4,2,8,5],times: 1), [9,10],"Not matching")
    }
    
    func testOddLengthArray1Times(){
        XCTAssertEqual(foldArray( [4,2],times: 1), [6],"Not matching")
        XCTAssertEqual(foldArray( [4,2,8,5,1],times: 1), [5,7,8],"Not matching")
    }
    
    func testOddLengthArrayNTimes(){
        XCTAssertEqual(foldArray( [4,2],times: 1), [6],"Not matching")
        XCTAssertEqual(foldArray( [4,2,8,5,1],times: 2), [13,7],"Not matching")
        XCTAssertEqual(foldArray( [4,2,8,5,1],times: 3), [20],"Not matching")
        XCTAssertEqual(foldArray( [4,2,8,5,1],times: 4), [20],"Not matching")
    }
    
    // 5,7,8
    // 13,7
}
XCTestObservationCenter.shared.addTestObserver(testObserver)
FoldingArrayTest.defaultTestSuite.run()

