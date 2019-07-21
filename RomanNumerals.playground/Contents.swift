import UIKit
import XCTest

var str = "===== Roman numerals ====="

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
 Create a function taking a positive integer as its parameter and returning a string containing the Roman Numeral representation of that integer.
 
 Modern Roman numerals are written by expressing each digit separately starting with the left most digit and skipping any digit with a value of zero. In Roman numerals 1990 is rendered: 1000=M, 900=CM, 90=XC; resulting in MCMXC. 2008 is written as 2000=MM, 8=VIII; or MMVIII. 1666 uses each Roman symbol in descending order: MDCLXVI.
 
 
 Symbol    Value
 I          1
 V          5
 X          10
 L          50
 C          100
 D          500
 M          1,000
 
 1990 => MCM
 
 2008 => MMVIII
 
 1666 => MDCLXVI
 
 2014 => 2000 , 000, 10, 4
 MMXIV
 */


enum RomanSymbol:String{
    case I // 1
    case V // 5
    case X // 10
    case L //  50
    case C //  100
    case D //  500
    case M //  1000
    case empty = ""
    

    
    static func convertToRoman(value: Int) -> RomanSymbol{
        
        switch value {
        case 1:
            return .I
        case 5:
            return .V
        case 10:
            return .X
        case 50:
            return .L
        case 100:
            return .C
        case 500:
            return .D
        case 1000:
            return .M
        default:
            return .empty
        }
    }
    
    static func liesInRange(value: Int) -> (Int,Int){
        
        switch value{
            case 1...4:
                return (1,5)
            case 5...9:
                return (5,10)
            case 10...40:
                return (10,50)
            case 50...90:
                return (50,100)
            case 100...400:
                return (100,500)
            case 500...900:
                return (500,1000)
            default :
                return (0,0)
        }
    }
}

func addIncreasingSymbols(number: Int, lowerBound: Int, upperBound: Int, multiplier: Int) -> String{
    
    var symbols :[String] = []
    //-- making 1 less
    if(upperBound-number == 1*multiplier){
        symbols = addSymbols(symbolVal: upperBound, multiplier: multiplier, incrementBy: number, whileLimit: upperBound)
        symbols.reverse()
    }else{
        symbols = addSymbols(symbolVal: lowerBound, multiplier: multiplier, incrementBy: lowerBound, whileLimit: number)
    }
    return symbols.joined()
}

func addSymbols(symbolVal: Int, multiplier: Int,incrementBy: Int, whileLimit: Int) -> [String]{
    var symbols : [String] = []
    symbols.append(RomanSymbol.convertToRoman(value: symbolVal).rawValue)
    var incrementBy = incrementBy
    
    //-- Add the lowerbound symbol * different
    while incrementBy < whileLimit{
        symbols.append(RomanSymbol.convertToRoman(value: multiplier).rawValue)
        incrementBy += multiplier
    }
    
   return symbols
}

func convertToRomanNumeral(number: Int) -> String{
    
    if number == 0{
        return RomanSymbol.empty.rawValue
    }
    
    let romanSymbol = RomanSymbol.convertToRoman(value: number).rawValue
    
    if(romanSymbol.isEmpty){
        //-- Convert to thousands, 100s, 10s and units
        let placeValues = convertNumberToPlaceValues(number: number)
        var symbols: [String] = []
        var placeValue = NSDecimalNumber(decimal: pow(10 , placeValues.count-1)).intValue
        
        for value in placeValues{
            if(value != 0){
                var symbol = RomanSymbol.convertToRoman(value: value).rawValue
                if(symbol.isEmpty){
                    //-- Find range
                    let range = RomanSymbol.liesInRange(value: value)
                    symbol = addIncreasingSymbols(number: value, lowerBound: range.0, upperBound: range.1, multiplier: placeValue)
                }
                symbols.append(symbol)
            }
            placeValue /= 10
        }
        return symbols.joined()
    }
    return romanSymbol
}

//-- Converts the given number to an array which contains the place values
func convertNumberToPlaceValues(number: Int) -> [Int]{
    var digits: [Int] = []
    var number = number
    var multiplier = 1
    
    while number > 0{
        digits.append((number % 10) * multiplier)
        number = number / 10
        multiplier *= 10
    }
    
    digits.reverse()
    return digits
}




class PlaceValueTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func testSingleDigits() {
        XCTAssertEqual(convertNumberToPlaceValues(number: 1), [1], "Not matching numbers ")
        XCTAssertEqual(convertNumberToPlaceValues(number: 8), [8], "Not matching numbers ")
    }
    
    func testMoreDigits() {
        
        XCTAssertEqual(convertNumberToPlaceValues(number: 1900), [1000,900,0,0], "Not matching numbers ")
        XCTAssertEqual(convertNumberToPlaceValues(number: 24), [20,4], "Not matching numbers ")
    }
}

//--MARK: Tests
class RomanNumeralsTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func testSingleSymbols() {
        XCTAssertEqual(convertToRomanNumeral(number: 0), "", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 1), "I", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 5), "V", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 10), "X", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 50), "L", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 100), "C", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 500), "D", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 1000), "M", "Not matching numbers ")
//        XCTAssertEqual(convertToRomanNumeral(number: 1023), "", "Not matching numbers ")
    }
    
    func testIncreasingRomanNumbers(){
        XCTAssertEqual(convertToRomanNumeral(number: 2), "II", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 3), "III", "Not matching numbers ")

//
        XCTAssertEqual(convertToRomanNumeral(number: 6), "VI", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 7), "VII", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 8), "VIII", "Not matching numbers ")
//
////
        XCTAssertEqual(convertToRomanNumeral(number: 11), "XI", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 12), "XII", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 13), "XIII", "Not matching numbers ")

    }
//
    func testLessThanRomanNumbers(){
        XCTAssertEqual(convertToRomanNumeral(number: 4), "IV", "Not matching numbers ")
        XCTAssertEqual(convertToRomanNumeral(number: 9), "IX", "Not matching numbers ")
    }

    func testBiggerNumbers(){
        // -- 10 - 4  XIV
        
        // -- 104 = 100 4  => CIV
         XCTAssertEqual(convertToRomanNumeral(number: 27), "XXVII", "Not matching numbers ")
        // -- 1023 = 1000 0 20 3   => MXXIII
        XCTAssertEqual(convertToRomanNumeral(number: 1023), "MXXIII", "Not matching numbers ")
        
        XCTAssertEqual(convertToRomanNumeral(number: 1333), "MCCCXXXIII", "Not matching numbers ")
        
        XCTAssertEqual(convertToRomanNumeral(number: 999), "CMXCIX", "Not matching numbers ")
        
        
        XCTAssertEqual(convertToRomanNumeral(number: 100), "C")
        XCTAssertEqual(convertToRomanNumeral(number: 444), "CDXLIV")
        XCTAssertEqual(convertToRomanNumeral(number: 1000), "M")
        XCTAssertEqual(convertToRomanNumeral(number: 1954), "MCMLIV")
        XCTAssertEqual(convertToRomanNumeral(number: 1990), "MCMXC")
        XCTAssertEqual(convertToRomanNumeral(number: 1999), "MCMXCIX")
        XCTAssertEqual(convertToRomanNumeral(number: 2000), "MM")
        XCTAssertEqual(convertToRomanNumeral(number: 2008), "MMVIII")
        XCTAssertEqual(convertToRomanNumeral(number: 3000), "MMM")
        XCTAssertEqual(convertToRomanNumeral(number: 3900), "MMMCM")
        XCTAssertEqual(convertToRomanNumeral(number: 3914), "MMMCMXIV")
        
        
    }
}

PlaceValueTests.defaultTestSuite.run()
RomanNumeralsTests.defaultTestSuite.run()
