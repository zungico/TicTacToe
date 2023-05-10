//
//  GameFieldView.swift
//  TicTacToe
//
//  Created by Вова on 07.05.2023.
//

import UIKit

class BoardView: UIView {
    
    //MARK: - Properties
    
    let boardSize = 3
    var isTouched = false
    var buttonArray: [UIButton] = []
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createBoard()
    }
    
    //MARK: - Create Board

    func createBoard() {
        let sizeButton = self.frame.width/CGFloat(boardSize)
        for i in 0...boardSize-1 {
            for j in 0...boardSize-1 {
                let button = UIButton(type: .system)
                button.frame.size = CGSize(width: sizeButton, height: sizeButton)
                button.frame.origin = CGPoint(x: CGFloat(j)*sizeButton,
                                              y: self.frame.height*0.2 + CGFloat(i)*sizeButton)
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderWidth = 4
                button.titleLabel?.font = UIFont.systemFont(ofSize: sizeButton/2)
                addSubview(button)
                button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
                buttonArray.append(button)
            }
        }
    }
    
    //MARK: - Helper Methods
    
    @objc func tapButton (_ sender: UIButton) {
        if isTouched {
            setSign(sender, letter: "O", color: .red)
        } else {
            setSign(sender, letter: "X", color: .black)
        }
        
    }
    
    func setSign (_ sender: UIButton, letter: String, color: UIColor) {
        isTouched.toggle()
        sender.setTitle(letter, for: .normal)
        sender.setTitleColor(color, for: .normal)
        sender.isEnabled = false
//        print (checkWin(location: sender.tag))
        print(checkRows())
        
    }
    
    func checkHorizontally(location: Int, x: Int) -> Bool {
        let first = location - (location % boardSize)
        let last = first + boardSize - 1
        var count = 0
        for i in first...last {
            if buttonArray[i].titleLabel?.text == buttonArray[location].titleLabel?.text {
                count += 1
            }
        }
        return count == boardSize
    }
    
    func checkVertically (location: Int, x: Int) -> Bool {
        var next = location + x
        var previous = location - x
        var count = 1
        var num1 = location
        var num2 = location
        while next < boardSize*boardSize {
            if (buttonArray[next].titleLabel?.text == buttonArray[num1].titleLabel?.text) {
                num1 = next
                count += 1
                next += x
            } else {
                break
            }
        }
        
        while previous >= 0 {
            if (buttonArray[previous].titleLabel?.text == buttonArray[num2].titleLabel?.text) {
                num2 = previous
                count += 1
                previous -= x
            } else {
                break
            }
        }
        
        if count >= boardSize {
            return true
        }
        return false
    }
    
    func checkDiagonally (location: Int, x: Int) -> Bool {
        var next = location + x
        var previous = location - x
        var count = 1
        var num1 = location
        var num2 = location
        while next < boardSize*boardSize {
            if (buttonArray[next].titleLabel?.text == buttonArray[num1].titleLabel?.text) &&
               (next/boardSize - num1/boardSize == 1) {
                num1 = next
                count += 1
                next += x
            } else {
                break
            }
        }
        
        while previous >= 0 {
            if (buttonArray[previous].titleLabel?.text == buttonArray[num2].titleLabel?.text) &&
               (previous/boardSize - num2/boardSize == -1) {
                num2 = previous
                count += 1
                previous -= x
            } else {
                break
            }
        }
        
        if count >= boardSize {
            return true
        }
        return false
        
    }
    
    func checkWin (location: Int) -> Bool {
        return checkHorizontally(location: location, x: 1)
//        checkVertically(location: location, x: boardSize) ||
//        checkDiagonally(location: location, x: boardSize-1) ||
//        checkDiagonally(location: location, x: boardSize+1)
    }
    
    func alert (message: String) {
        let alertController = UIAlertController(title: "WIN", message: message, preferredStyle: .alert)
//        self.present(alertController, animated: true))
    }
    
    func checkRows() -> Bool {
        // Check horizontal rows
        for i in 0..<boardSize {
            if checkRow(row: i * boardSize, length: boardSize) {
                return true
            }
        }
        
        // Check vertical rows
        for i in 0..<boardSize {
            if checkRow(row: i, length: boardSize) {
                return true
            }
        }
        
        return false
    }

    func checkRow(row: Int, length: Int) -> Bool {
        var countX = 0
        var countO = 0
        
        for i in 0..<length {
            let index = row + i
            let title = buttonArray[index].titleLabel?.text
            
            if title == "X" {
                countX += 1
            } else if title == "O" {
                countO += 1
            }
        }
        
        return countX == length || countO == length
    }

}
