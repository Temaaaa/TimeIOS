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
    
    @IBOutlet weak var tableLap: UITableView!
    @IBAction func activateTimer(_ sender: UIButton) {
        stopWatch = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(tikTok), userInfo: nil, repeats: true)
    }
    
    @IBAction func addLap(_ sender: UIButton) {
        lapArray.append(timerOutput.text!)
        tableLap.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = lapArray[indexPath.row]
        return cell
    }


}

