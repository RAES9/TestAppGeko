//
//  LogInViewController.swift
//  TestApp
//
//  Created by Research Mobile on 10/17/19.
//  Copyright © 2019 Esteban Rivas. All rights reserved.
//

import UIKit
import CoreData

class LogInViewController: UIViewController {
    @IBOutlet weak var input_pass: UITextField!
    @IBOutlet weak var input_email: UITextField!
    var validate = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        validate = false
        input_email.text = ""
        input_pass.text = ""
    }
    @IBAction func logIn(_ sender: Any) {
        if input_pass.text == "" || input_email.text == "" {
            let alert = UIAlertController(title: "¡Wait!", message: "You must complete all fields.", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            retrieveData()
        }
        
    }
    func retrieveData() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
            do {
                let result = try managedContext.fetch(fetchRequest)
                print(result)
                if result.count == 0 {
                   let alert = UIAlertController(title: "¡Wait!", message: "There is no registered user.", preferredStyle: .alert )
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "email") as! String)
                    print(data.value(forKey: "password") as! String)
                    print(data.value(forKey: "number") as! String)
                    if (data.value(forKey: "email") as! String) == input_email.text && (data.value(forKey: "password") as! String) == input_pass.text{
                        validate = true
                        Singleton.instance.username = (data.value(forKey: "email") as! String)
                        Singleton.instance.name = (data.value(forKey: "username") as! String)
                        Singleton.instance.number = (data.value(forKey: "number") as! String)
                    }
                }
                if validate {
                    performSegue(withIdentifier: "SegueLogin", sender: nil)
                }else{
                    let alert = UIAlertController(title: "¡Wait!", message: "The email or password is incorrect.", preferredStyle: .alert )
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } catch {
                
                print("Failed")
            }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           view.endEditing(true)
           super.touchesBegan(touches, with: event)
       }
}
