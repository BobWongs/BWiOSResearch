//
//  main.swift
//  BWSwiftResearch-MacOS
//
//  Created by BobWong on 16/8/5.
//  Copyright © 2016年 BobWong. All rights reserved.
//

import Foundation

func test0() {
    print("Hello, World!")
    
    // Error
    //var person0: String?
    //print(person0!)
    
    let person1 = "1"
    print(person1)
    
    // Error
    //var person2 = nil
    //print(person2)
    
    let person3: String? = "3"
    print(person3!)
}

func test1() {
    let array0 = [1, 2, 3, 4, 5]
    let array1 = ["a", "b", "cd", "d", "esf"]
    print(array0)
    for item in array0 {
        print(item)
        print(type(of: item))
    }
    
    for item in array1 {
        print(item)
        print(type(of: item))
    }
    
    
    let dict0 = ["first": "one", "second": "two", "third": "three"]
    print(dict0)
    for (k, v) in dict0 {
        print("\(k): \(v)")
    }
    let dict0Keys = [String](dict0.keys)
    print(dict0Keys)
}

func test2() {
    let dict0: [String] = []
    var dict1 = dict0
    dict1.append("one")
    print("dict0: \(dict0)")
    print("dict1: \(dict1)")
}

//test2()

func test3(a: Int, b: Int) {
    print("test3")
}

func test4() {
    test3(a: 32, b: 12)
    print(type(of: test3))
    let closure0: (Int) -> () = {
        (a: Int) -> () in
        print("Closure0")
        print("Closure00")
    }
    
    closure0(12)
    print(type(of: closure0))
}

//test4()

func test5() {
    let a: Int = 12
    let b: Float = 12.1
    let c: Double = 12.32
    let d: Character = "a"
    let e: UInt64 = 32
    
    print(type(of: a))
    print(type(of: b))
    print(type(of: c))
    print(type(of: d))
    print(type(of: e))
}

//test5()

func test6() {
    struct Structure0 {
        var property0: Int = 10
        var property1: Int = 10
    }
    
    var structure0 = Structure0()
    structure0.property0 = 21
    print(type(of:structure0))
}

//test6()

func test7() {
    enum ControlState {
        case Normal, Selected, Highlighted
    }
    
    let state = ControlState.Normal
    print(state)
    
    // Error
//    let stateInt: Int = state
//    print(stateInt)
}

//test7()


func test8() {
    var condition0 = true
    if condition0 {
        print("true")
    }
    
    let b = condition0 ? 212 : 32
    print(b)
}

//test8()

func test9() {
    
}
