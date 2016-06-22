import UIKit

func oddBall(userArray: [Int]) -> [Int] {
    var result = [Int]()
    
    for item in userArray {
        if item % 2 > 0 {
            result.append(item)
        }
    }
    return result
}

let myArray = [1, 2, 5, 7, 12, 24, 67]

oddBall(myArray)