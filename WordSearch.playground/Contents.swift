import UIKit
import XCTest

var str = "==== Word search ======"



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

/**
 Write a method that will search an array of strings for all strings that contain another string, ignoring capitalization. Then return an array of the found strings.
 
 The method takes two parameters, the query string and the array of strings to search, and returns an array.
 
 If the string isn't contained in any of the strings in the array, the method returns an array containing a single string: "Empty" (or Nothing in Haskell, or "None" in Python and C)
 
 Examples
 If the string to search for is "me", and the array to search is ["home", "milk", "Mercury", "fish"], the method should return ["home", "Mercury"].
 */

func wordSearch(_ str:String, _ arr:[String]) -> [String] {
    var foundStrings = arr.filter { (val) -> Bool in
        val.lowercased().contains(str.lowercased())
    }
    
    if(foundStrings.count == 0){
        foundStrings.append("Empty")
    }
    return foundStrings
}

class WordSearchTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    func testNotFound() {
        XCTAssertEqual(wordSearch("hello", ["howare you","I am fine"]), ["Empty"], " matching words ")
    }
    
    func testFullMatch() {
        XCTAssertEqual(wordSearch("hello", ["hello","hellw"]), ["hello"], "Not matching words ")
        XCTAssertEqual(wordSearch("me", ["Mercury","home","bounce"]), ["Mercury","home"], "Not matching words ")
    }
}

WordSearchTests.defaultTestSuite.run()

