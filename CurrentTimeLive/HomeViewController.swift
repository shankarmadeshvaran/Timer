//
//  HomeViewController.swift
//  CurrentTimeLive
//
//  Created by Shankar on 21/05/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var labelCurrentTime: UILabel!
    
    var timer = Timer()
    
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var updatingSeconds = 0 {
        didSet {
            if self.updatingSeconds == 60 {
                self.updatingSeconds = 0
            }
            labelCurrentTime.text = getCurrentHourMinSecond()
        }
    }
    
    var isTimerRunning = false {
        didSet {
            if isTimerRunning {
                runTimer()
            } else {
                timer.invalidate()
            }
        }
    }
    
    var calendar: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return calendar
    }
    
    var currentHour: Int {
        return calendar.component(.hour, from: Date.today)
    }
    
    var currentMinute: Int {
        return calendar.component(.minute, from: Date.today)
    }
    
    var currentSecond: Int {
        return calendar.component(.second, from: Date.today)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updatingSeconds = currentSecond
        labelCurrentTime.text = getCurrentHourMinSecond()
        isTimerRunning = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStop.layer.borderColor = UIColor.white.cgColor
        buttonStop.layer.borderWidth = 2
    }

    //Make Timer invalidate when viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isTimerRunning = false
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        updatingSeconds += 1
    }
    
    func getCurrentHourMinSecond() -> String {
        let hourInTwoDigits = String(format: "%02d", currentHour)
        let minuteInTwoDigits = String(format: "%02d", currentMinute)
        let secondsInTwoDigits = String(format: "%02d", updatingSeconds)
        
        return ("\(hourInTwoDigits) : \(minuteInTwoDigits) : \(secondsInTwoDigits)")
    }
    
    @IBAction func buttonStartTimer(_ sender: Any) {
        updatingSeconds = currentSecond
        labelCurrentTime.text = getCurrentHourMinSecond()
        isTimerRunning = true
    }
    
    @IBAction func buttonStopTimer(_ sender: Any) {
        isTimerRunning = false
    }
    
}

extension Date {
    static var today: Date { return Date() }
}
