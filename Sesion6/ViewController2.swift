//
//  ViewController2.swift
//  Sesion6
//
//  Created by Jan Zelaznog on 26/03/22.
//

import UIKit

class ViewController2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // Implementación de un pickerview con el storyboard
    @IBOutlet weak var picker: UIPickerView!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Esta es la fila \(row)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
