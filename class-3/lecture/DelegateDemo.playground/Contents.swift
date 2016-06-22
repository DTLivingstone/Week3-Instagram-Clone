//: Playground - noun: a place where people can play

import UIKit



//DELEGATE PROTOCOL
protocol ViewController1Delegate: class{
    func passDataToNextViewController(string: String)
}




//CLASS 1
class MyViewController1{
    
    weak var delegate: ViewController1Delegate?
    
    func demonstrateDelegation(){
        if let delegate = self.delegate{
            delegate.passDataToNextViewController("Hello ViewController 2!!")
        }
    }
    
}

//CLASS 2 - TO DELEGATE CLASS 1
class MyViewController2: ViewController1Delegate {
    
    let tableView = MyViewController1()
    
    var someCrazyString : String?

    
    func passDataToNextViewController(string: String) {
        self.someCrazyString = string
    }
    
    
}

let firstVC = MyViewController1()
let secondVC = MyViewController2()

//
firstVC.delegate = secondVC
//
secondVC.someCrazyString
//
firstVC.demonstrateDelegation()
//
secondVC.someCrazyString













