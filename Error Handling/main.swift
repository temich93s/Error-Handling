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


//MARK: Передача ошибки с помощью генерирующей функции
print("\n//Передача ошибки с помощью генерирующей функции")

struct Item {
    var price: Int
    var count: Int
}
 
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}


//MARK: Обработка ошибок с использованием do-catch
print("\n//Обработка ошибок с использованием do-catch")

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8

do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("Ошибка выбора.")
} catch VendingMachineError.outOfStock {
    print("Нет в наличии.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Недостаточно средств. Пожалуйста вставьте еще \(coinsNeeded) монетки.")
} catch {
    print("Неожиданная ошибка: \(error).")
}
// Выведет "Недостаточно средств. Пожалуйста вставьте еще 2 монетки.

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Некорректный вывод, нет в наличии или недостаточно денег.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}
// Выведет "Некорректный вывод, нет в наличии или недостаточно денег."
