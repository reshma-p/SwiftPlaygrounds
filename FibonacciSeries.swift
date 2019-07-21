#!/usr/bin/swift
//
//  FibonacciSeries.swift
//  
//
//  Created by Reshma Pinto on 19/07/2019.
//

import Foundation


func fibonacci(_ n: Int) -> Int {
    if n <= 2 {
        return 1
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
}

print(fibonacci(50))
