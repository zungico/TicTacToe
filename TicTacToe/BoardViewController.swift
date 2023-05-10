//
//  ViewController.swift
//  TicTacToe
//
//  Created by Вова on 07.05.2023.
//

import UIKit

class BoardViewController: UIViewController {
    
    var boardSize = 3
    var isTouched = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createBoard()
    }
    
    
    //MARK: - Create Board

    func createBoard() {
        let sizeButton = self.view.frame.width/CGFloat(boardSize)
        for i in 0...boardSize-1 {
            for j in 0...boardSize-1 {
                let button = UIButton(type: .system)
                button.frame.size = CGSize(width: sizeButton, height: sizeButton)
                button.frame.origin = CGPoint(x: CGFloat(j)*sizeButton,
                                              y: self.view.frame.height*0.2 + CGFloat(i)*sizeButton)
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderWidth = 0.5
                button.titleLabel?.font = UIFont.systemFont(ofSize: sizeButton/2)
                view.addSubview(button)
                button.addTarget(self, action: #selector(tapButton(_:)), for: .allEvents)
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
    }
}


