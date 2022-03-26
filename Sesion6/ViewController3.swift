//
//  ViewController3.swift
//  Sesion6
//
//  Created by Jan Zelaznog on 26/03/22.
//

import UIKit

class ViewController3: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let text = UITextField()
    let picker = UIPickerView()
    var datos = [[String:Any]]()
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let elDict = datos[row]
        // del diccionario obtenemos el valor en la llave "entidad"
        let nombre = (elDict["entidad"] as? String) ?? "\(row)"
        text.text = nombre
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // obtenemos el diccionario
        let elDict = datos[row]
        // del diccionario obtenemos el valor en la llave "entidad"
        let nombre = (elDict["entidad"] as? String) ?? "\(row)"
        return nombre
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // permite capturar los touches en cualquier parte de la vista donde no haya otro control que pueda recibir el evento
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        // NO agregamos el picker a la vista, para que sea el textfield el que lo invoque cuando lo necesite
        // self.view.addSubview(picker)
        obtenInfo()
        text.borderStyle = .roundedRect
        text.backgroundColor = .lightGray
        self.view.addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        picker.translatesAutoresizingMaskIntoConstraints = false
        // le asignamos un objeto para ingresar datos, distinto del teclado estándar
        // text.inputView = picker
        // para evitar que se pueda escribir en el cuadro de texto (pero entonces ya no recibe el touch)
        // text.isEnabled = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            text.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            text.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            text.heightAnchor.constraint(equalToConstant: 45)
        ])
        /* Los constraints ya no son necesarios porque el picker no se va a mostrar en la vista
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 20),
            picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        */
    }
    
    func obtenInfo() {
        // encuentra la ubicación en tiempo de ejecución de un archivo agregado al proyecto
        if let rutaAlArchivo = Bundle.main.url(forResource: "edo-mun", withExtension: "plist") {
            do {
                let bytes = try Data(contentsOf: rutaAlArchivo)
                let tmp = try PropertyListSerialization.propertyList(from: bytes, options: .mutableContainers, format:nil)
                datos = tmp as! [[String:Any]]
            }
            catch {
                // manejar el error
                print (error.localizedDescription)
            }
        }
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
