import Foundation

public extension Int {
    
    var roman: String? {
        
        let values = [ 1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        let literals = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV","I"]
        
        var value = self
        var roman = ""
        
        if(value <= 0) {
            return nil
        }
        
        for i in 0..<values.count {
            
            while(value >= values[i]) {
             
                value -= values[i]
                roman += literals[i]
            }
        }
       
        return roman
    }
}
