import UIKit

var greeting = "Hello, playground"


struct dataprovider {
    
    let provideData: (_ count: Int) -> [Int]
    
    static func getShuffledProvider() -> dataprovider {
        return dataprovider { count in
            return [1,2,3,4,5]
        }
    }
}


let test = dataprovider.getShuffledProvider()
print(test.provideData(3))
print(test.provideData(3))
