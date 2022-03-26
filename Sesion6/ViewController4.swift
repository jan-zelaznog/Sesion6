//
//  ViewController4.swift
//  Sesion6
//
//  Created by Jan Zelaznog on 26/03/22.
//

import UIKit

class ViewController4: UIViewController {
    var tecladoArriba = false
    let nom = UITextField()
    let app = UITextField()
    let apm = UITextField()
    let tel = UITextField()
    let mel = UITextField()
    let scroll = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nom.autocorrectionType = .yes
        app.autocorrectionType = .yes
        apm.autocorrectionType = .yes
        tel.keyboardType = .phonePad
        mel.autocorrectionType = .no
        mel.keyboardType = .emailAddress
        mel.autocapitalizationType = .none
        // primero se agrega el scroll view
        self.view.addSubview(scroll)
        // después se agregan todos los subviews dentro del scroll
        scroll.addSubview(nom)
        scroll.addSubview(app)
        scroll.addSubview(apm)
        scroll.addSubview(tel)
        scroll.addSubview(mel)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        nom.translatesAutoresizingMaskIntoConstraints = false
        app.translatesAutoresizingMaskIntoConstraints = false
        apm.translatesAutoresizingMaskIntoConstraints = false
        tel.translatesAutoresizingMaskIntoConstraints = false
        mel.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .systemBlue
        let gesto = UITapGestureRecognizer(target: self, action:#selector(desactivaTeclado))
        scroll.addGestureRecognizer(gesto)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for view in scroll.subviews {
            if view is UITextField {
                let text = view as! UITextField
                text.borderStyle = .roundedRect
                text.backgroundColor = .lightGray
            }
        }
        // el centro de notificaciones permite enviar y recibir mensajes entre distintos objetos sin una relación entre ellos
        // me suscribo a las notificaciones cuando el teclado aparezca o desaparezca para ajustar el tamaño del content y que empiece a funcionar el scroll
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoAparece(_ :)), name:UIResponder.keyboardDidShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoDesaparece(_ :)), name:UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // me desuscribo del NC para no recibir notificaciones si no es la vista activa
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func desactivaTeclado() {
        self.view.endEditing(true)
    }
    
    @objc func tecladoAparece(_ notif: Notification) {
        print ("up")
        if tecladoArriba {
            return
        }
        tecladoArriba = true
        // Obtenemos el tamaño final del teclado
        if let tamanioTeclado = (notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // aumentamos el tamaño del content, para que haga scroll
            scroll.contentSize.height += tamanioTeclado.height
        }
    }
    
    @objc func tecladoDesaparece(_ notif: Notification) {
        if !tecladoArriba {
            return
        }
        tecladoArriba = false
        // Obtenemos el tamaño final del teclado
        if let tamanioTeclado = (notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // reducimos el tamaño del content, para que ya no haga scroll cuando se oculte el teclado
            scroll.contentSize.height -= tamanioTeclado.height
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            nom.topAnchor.constraint(equalTo:scroll.topAnchor, constant: 50),
            nom.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            nom.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor, constant: -20),
            nom.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            app.topAnchor.constraint(equalTo:nom.bottomAnchor, constant: 50),
            app.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            app.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor, constant: -20),
            app.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            apm.topAnchor.constraint(equalTo:app.bottomAnchor, constant: 50),
            apm.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            apm.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor, constant: -20),
            apm.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            tel.topAnchor.constraint(equalTo:apm.bottomAnchor, constant: 50),
            tel.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            tel.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor, constant: -20),
            tel.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            mel.topAnchor.constraint(equalTo:tel.bottomAnchor, constant: 50),
            mel.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            mel.widthAnchor.constraint(equalToConstant: 150),
            mel.heightAnchor.constraint(equalToConstant: 50)
        ])
        // el objeto contentView es el que determina si se necesita hacer scroll
        scroll.contentLayoutGuide.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, constant: 0).isActive = true
        scroll.contentLayoutGuide.heightAnchor.constraint(equalTo:scroll.frameLayoutGuide.heightAnchor, constant: 20).isActive = true
    }

}
