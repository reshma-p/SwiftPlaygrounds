import UIKit

var str = "=== Jumps calculator"

func solution(n: Int) -> Int {

    if (n <= 1) {
        return 1
    } else if (n == 2) {
        return 2
    }
    
    var res: [Int] = [1,1,2]
    
    for index in 3...n-1{
        res.append(res[index - 1] + res[index - 2] + res[index - 3])
    }
    return res.last!
}

print(solution(n: 1))
print(solution(n: 39))

