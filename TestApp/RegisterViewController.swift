//
//  RegisterViewController.swift
//  TestApp
//
//  Created by Research Mobile on 10/17/19.
//  Copyright © 2019 Esteban Rivas. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    @IBOutlet weak var input_number: UITextField!
    @IBOutlet weak var input_name: UITextField!
    @IBOutlet weak var input_email: UITextField!
    @IBOutlet weak var input_pass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    override func viewWillAppear(_ animated: Bool) {
        input_email.text = ""
        input_pass.text = ""
        input_name.text = ""
        input_number.text = ""
    }
    @IBAction func create(_ sender: Any) {
        if !isNumberValid(input_number.text!) {
            let alert = UIAlertController(title: "¡Wait!", message: "You must enter a valid number.", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if !isPasswordValid(input_pass.text!){
            let alert = UIAlertController(title: "¡Wait!", message: "Your password must include: One or more uppercase characters, One or more lowercase characters, One or more digits, One or more special characters and at least 6 characters.", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if !isValidEmail(testStr: input_email.text!) {
            let alert = UIAlertController(title: "¡Wait!", message: "You must enter a valid email.", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if input_number.text == "" || input_name.text == ""{
            let alert = UIAlertController(title: "¡Wait!", message: "You must complete all fields.", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(input_name.text!, forKey: "username")
            user.setValue(input_email.text!, forKey: "email")
            user.setValue(input_number.text!, forKey: "number")
            user.setValue(input_pass.text!, forKey: "password")
            do {
                try managedContext.save()
                let alert = UIAlertController(title: "", message: "The user has been created correctly.", preferredStyle: .alert )
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            input_email.text = ""
            input_pass.text = ""
            input_name.text = ""
            input_number.text = ""
        }
        
    }
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,}")
        return passwordTest.evaluate(with: password)
    }
    func isNumberValid(_ value : String) -> Bool{
        let PHONE_REGEX = "^[0-9]{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           view.endEditing(true)
           super.touchesBegan(touches, with: event)
       }
}
