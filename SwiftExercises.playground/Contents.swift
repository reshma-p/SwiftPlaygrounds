import UIKit


// MARK: Variadic parameters
func sum(isIt: Bool,of numbers: Double..., argu: Bool) -> Double{
    var sum: Double  = 0
    
    for value in numbers {
        sum += value
    }
    return sum
}
let total = sum(isIt: true, of: 1,2,5,6 ,argu: false)
print("Sum of the values : \(total)")

