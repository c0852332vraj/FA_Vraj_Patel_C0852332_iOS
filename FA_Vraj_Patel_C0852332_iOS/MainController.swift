//
//  MainController.swift
//  FA_Vraj_Patel_C0852332_iOS
//
//  Created by Vraj Patel on 30/05/22.
//

import UIKit


enum MoveName : String {
    case a1
    case a2
    case a3
    case b1
    case b2
    case b3
    case c1
    case c2
    case c3
}

class MainController: UIViewController {
    
   
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var WinX: UILabel!
    @IBOutlet weak var WinO: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    
    enum Turn {
        case Nought
        case Cross
    }
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    var arrayBtnTag : [Int] = []
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var noughtsWin = 0
    var crossesWin = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        boardInitialize()
}
    
    
    
    @IBAction func boardTapAction(_ sender: UIButton)
    {
        addToBoard(sender)

        if cheakWins(CROSS)
        {
            crossesWin += 1
            winAlertMsg(title: "Crosses Win!")
            WinX.text = "Win 0 : \(crossesWin)"
        }

        if cheakWins(NOUGHT)
        {
            noughtsWin += 1
            winAlertMsg(title: "Noughts Win!")
            WinO.text = "Win 0 : \(noughtsWin)"
        }

        if(boardWhole())
        {
            winAlertMsg(title: "Draw")
        }
    }

    
    
    func cheakWins(_ s :String) -> Bool
    {
        // Horizontal win
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
        {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
        {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
        {
            return true
        }

        // Vertical Win
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
        {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
        {
            return true
        }

        // Diagonal win
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
        {
            return true
        }

        return false
    }

    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func thatSymbol(_ button: UIButton) -> Bool
      {
          return (button.title(for: .normal) != nil)
      }
    func winAlertMsg(title: String)
    {
        let message = "\nNoughts " + String(noughtsWin) + "\n\nCrosses " + String(crossesWin)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.boardRes()
        }))
        self.present(ac, animated: true)
    }

    func boardRes()
    {
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought
        {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if firstTurn == Turn.Cross
        {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
    }

    func boardWhole() -> Bool
    {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }

    func addToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(currentTurn == Turn.Nought)
            {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if(currentTurn == Turn.Cross)
            {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
        {
            if motion == .motionShake {
               undoCheaking()

                if(currentTurn == Turn.Nought)
                {
                    currentTurn = Turn.Cross
                    turnLabel.text = CROSS
                }
                else if(currentTurn == Turn.Cross)
                {

                    currentTurn = Turn.Nought
                    turnLabel.text = NOUGHT
                }
                
            }
            
        }
    
    func undoCheaking()
        {

            for button in board
            {
                if button == a1
                {
                    button.setTitle(nil, for: .normal)
                    button.isEnabled = true
                }
                if button == a2
                {
                    button.setTitle(nil, for: .normal)
                    button.isEnabled = true
                }
                if button == a3
                {
                    button.setTitle(nil, for: .normal)
                    button.isEnabled = true
                }
                if button == b1
                {
                    button.setTitle(nil, for: .normal)
                    button.isEnabled = true
                }
                if button == b2
                {
                    button.setTitle(nil, for: .normal)
                    button.isEnabled = true
                }
                if button == b3
                {
                    button.setTitle(nil, for: .normal)
                    button.isEnabled = true
                }
                if button == c1
                {
                    button.setTitle(nil, for: .normal)
                    button.isEnabled = true
                }
                if button == c2
                {
                    button.setTitle(nil, for: .normal)
                    button.isEnabled = true
                }
                if button == c3
                {
                    button.setTitle(nil, for: .normal)
                    button.isEnabled = true
                }

            }
        }
    
    func boardInitialize()
        {
            a1.tag = 1
            a2.tag = 2
            a3.tag = 3
            b1.tag = 4
            b2.tag = 5
            b3.tag = 6
            c1.tag = 7
            c2.tag = 8
            c3.tag = 9
            
            
            board.append(a1)
            board.append(a2)
            board.append(a3)
            board.append(b1)
            board.append(b2)
            board.append(b3)
            board.append(c1)
            board.append(c2)
            board.append(c3)
        }
    
    func toMove(index : Int) -> MoveName {
        var move = MoveName.a1
        if index == 1 {
            move = .a1
        } else if index == 2 {
            move = .a2
        } else if index == 3 {
            move = .a3
        } else if index == 4 {
            move = .b1
        } else if index == 5 {
            move = .b2
        } else if index == 6 {
            move = .b3
        } else if index == 7 {
            move = .c1
        } else if index == 8 {
            move = .c2
        } else if index == 9 {
            move = .c3
        }
        return move
    }
}
