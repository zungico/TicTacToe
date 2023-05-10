//
//  ViewController.swift
//  TicTacToe
//
//  Created by Вова on 07.05.2023.
//

import UIKit

class BoardViewController: UIViewController {
    
    override func loadView() {
        self.view = BoardView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        
    }

}


