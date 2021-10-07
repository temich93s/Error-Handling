//
//  main.swift
//  Error Handling
//
//  Created by 2lup on 07.10.2021.
//

import Foundation

print("Hello, World!")


//MARK: Отображение и генерация ошибок
print("\n//Отображение и генерация ошибок")

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

//throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
