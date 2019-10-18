//
//  InitialViewController.swift
//  TestApp
//
//  Created by Research Mobile on 10/17/19.
//  Copyright © 2019 Esteban Rivas. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_number: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_email.text = Singleton.instance.username
        lbl_name.text = Singleton.instance.name
        lbl_number.text = Singleton.instance.number
        overrideUserInterfaceStyle = .light
    }
    @IBAction func back_button(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           view.endEditing(true)
           super.touchesBegan(touches, with: event)
       }
}

