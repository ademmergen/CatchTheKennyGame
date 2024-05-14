//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Adem Mergen on 19.03.2023.
//


import UIKit

class ViewController: UIViewController {
    
    //Variables
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer ()
    var highScore = 0
    
    //Views
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        scoreLabel.text = "Score: \(score)"
        
        //Highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "\(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        //Images
        for _ in 1...9 {
            let kennyImageView = UIImageView()
            kennyImageView.isUserInteractionEnabled = true
            kennyImageView.image = UIImage(named: "kenny")
            kennyImageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(kennyImageView) // Ekran üzerine ekle
            kennyArray.append(kennyImageView)
            
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            kennyImageView.addGestureRecognizer(recognizer)
        }
        
        // Kenny Constraints
        NSLayoutConstraint.activate([
            // Kenny1
            kennyArray[0].widthAnchor.constraint(equalToConstant: 115),
            kennyArray[0].heightAnchor.constraint(equalToConstant: 100),
            kennyArray[0].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            kennyArray[0].leftAnchor.constraint(equalTo: view.centerXAnchor, constant: -180),
            
            // Kenny2
            kennyArray[1].widthAnchor.constraint(equalToConstant: 115),
            kennyArray[1].heightAnchor.constraint(equalToConstant: 100),
            kennyArray[1].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            kennyArray[1].leftAnchor.constraint(equalTo: kennyArray[0].rightAnchor, constant: 5),
            
            // Kenny3
            kennyArray[2].widthAnchor.constraint(equalToConstant: 115),
            kennyArray[2].heightAnchor.constraint(equalToConstant: 100),
            kennyArray[2].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            kennyArray[2].leftAnchor.constraint(equalTo: kennyArray[1].rightAnchor, constant: 5),
            
            // Kenny4
            kennyArray[3].widthAnchor.constraint(equalToConstant: 115),
            kennyArray[3].heightAnchor.constraint(equalToConstant: 100),
            kennyArray[3].topAnchor.constraint(equalTo: kennyArray[0].bottomAnchor, constant: 100),
            kennyArray[3].leftAnchor.constraint(equalTo: view.centerXAnchor, constant: -180),
            
            // Kenny5
            kennyArray[4].widthAnchor.constraint(equalToConstant: 115),
            kennyArray[4].heightAnchor.constraint(equalToConstant: 100),
            kennyArray[4].topAnchor.constraint(equalTo: kennyArray[1].bottomAnchor, constant: 100),
            kennyArray[4].leftAnchor.constraint(equalTo: kennyArray[3].rightAnchor, constant: 5),
            
            // Kenny6
            kennyArray[5].widthAnchor.constraint(equalToConstant: 115),
            kennyArray[5].heightAnchor.constraint(equalToConstant: 100),
            kennyArray[5].topAnchor.constraint(equalTo: kennyArray[2].bottomAnchor, constant: 100),
            kennyArray[5].leftAnchor.constraint(equalTo: kennyArray[4].rightAnchor, constant: 5),
            
            // Kenny7
            kennyArray[6].widthAnchor.constraint(equalToConstant: 115),
            kennyArray[6].heightAnchor.constraint(equalToConstant: 100),
            kennyArray[6].topAnchor.constraint(equalTo: kennyArray[3].bottomAnchor, constant: 100),
            kennyArray[6].leftAnchor.constraint(equalTo: view.centerXAnchor, constant: -180),
            
            // Kenny8
            kennyArray[7].widthAnchor.constraint(equalToConstant: 115),
            kennyArray[7].heightAnchor.constraint(equalToConstant: 100),
            kennyArray[7].topAnchor.constraint(equalTo: kennyArray[4].bottomAnchor, constant: 100),
            kennyArray[7].leftAnchor.constraint(equalTo: kennyArray[6].rightAnchor, constant: 5),
            
            // Kenny9
            kennyArray[8].widthAnchor.constraint(equalToConstant: 115),
            kennyArray[8].heightAnchor.constraint(equalToConstant: 100),
            kennyArray[8].topAnchor.constraint(equalTo: kennyArray[5].bottomAnchor, constant: 100),
            kennyArray[8].leftAnchor.constraint(equalTo: kennyArray[7].rightAnchor, constant: 5)
        ])

        
        //Timers
        counter = 20
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
    }
    
    @objc func hideKenny () {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    @objc func increaseScore () {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            //Highscore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {(UIAlertAction) in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 20
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}



