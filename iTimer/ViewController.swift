//
//  ViewController.swift
//  iTimer
//
//  Created by Student on 23.03.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    var stopWatch = Timer()
    var counter: Double = 0.0
    var lapArray: [String] = []
    var isPlay: Bool = false
    
    @IBOutlet weak var tableLap: UITableView!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func activateTimer(_ sender: UIButton){
        isPlay = !isPlay
        if isPlay {
            stopWatch = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(tikTok), userInfo: nil, repeats: true)
            let image = UIImage(systemName: "pause.fill")
            sender.setImage(image, for: .normal)
            sender.setTitle("Pause", for: .normal)
            let imageReset = UIImage(systemName: "plus.rectangle.fill")
            resetButton.setImage(imageReset, for: .normal)
            resetButton.setTitle("Lap", for: .normal)
            resetButton.isEnabled = true
           
            
        } else {
            stopWatch.invalidate()
            let image = UIImage(systemName: "play.fill")
            sender.setImage(image, for: .normal)
            sender.setTitle("Start", for: .normal)
            let imageReset = UIImage(systemName: "trash.fill")
            resetButton.setImage(imageReset, for: .normal)
            resetButton.setTitle("Reset", for: .normal)
        }
        
    }
    
    @IBAction func addLap(_ sender: UIButton) {
        if isPlay{
        lapArray.append(timerOutput.text!)
        tableLap.reloadData()
            
        } else {
            counter = 0.0
            timerOutput.text = "00:00"
            lapArray.removeAll()
            tableLap.reloadData()
            sender.isEnabled = false
        }
        
    }
    
    @objc func tikTok() {
        counter += 0.1
        var minute: String = "\(Int(counter) / 60)"
        if Int(minute)! < 10 {
            minute = "0\(minute)"
        }
        
        var seconds: String = String(format: "%.1f",counter.truncatingRemainder(dividingBy: 60))
        if Int(counter.truncatingRemainder(dividingBy: 60)) < 10 {
            seconds = "0\(seconds)"
        }
        
        timerOutput.text = "\(minute):\(seconds)"
        
    }
    
    
    @IBOutlet weak var timerOutput: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableLap.delegate = self
        tableLap.dataSource = self
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! row
        
        cell.rowLabel.text = lapArray[indexPath.row]
        return cell
    }


}

class row: UITableViewCell {
    
    @IBOutlet weak var rowLabel: UILabel!
    
}

