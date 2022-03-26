//
//  ViewController.swift
//  Sesion6
//
//  Created by Jan Zelaznog on 26/03/22.
//

import UIKit

class ViewController: UIViewController {
    let df = DateFormatter()
    @IBOutlet weak var fecha:UILabel!
    @IBOutlet weak var datepicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func eligeFecha(_ sender: Any) {
        df.dateFormat = "dd - MM - yy"
        fecha.text = df.string(from:datepicker.date)
    }
    
}

