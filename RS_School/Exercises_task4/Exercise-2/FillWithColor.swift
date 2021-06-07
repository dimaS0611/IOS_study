import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        
        var newImage : [[Int]] = image
        let initColor = image[row][column]
        
        var queue : [(Int, Int)] = [(row, column)]
        
        while !queue.isEmpty {
            let newCell = queue.removeFirst()
            newImage[newCell.0][newCell.1] = newColor
            
            if(newCell.0 + 2 <= newImage.count && newImage[newCell.0 + 1][newCell.1] == initColor) {
                queue.append((newCell.0 + 1, newCell.1))
            }
            if(newCell.1 + 2 <= newImage[0].count && newImage[newCell.0][newCell.1 + 1] == initColor) {
                queue.append((newCell.0, newCell.1 + 1))
            }
            if(newCell.0 - 1 >= 0 &&  newImage[newCell.0 - 1][newCell.1] == initColor) {
                queue.append((newCell.0 - 1, newCell.1))
            }
            if(newCell.1 - 1 >= 0 && newImage[newCell.0][newCell.1 - 1] == initColor) {
                queue.append((newCell.0, newCell.1 - 1))
            }
        }
        
        
        return newImage
    }
}
