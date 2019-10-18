//
//  ViewController.swift
//  TestApp
//
//  Created by Research Mobile on 10/17/19.
//  Copyright © 2019 Esteban Rivas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var logIn : UIViewController?
    var register : UIViewController?
    @IBOutlet weak var contentVC: UIView!
    @IBOutlet weak var view_btn_sing: UIView!
    @IBOutlet weak var view_btn_log: UIView!
    @IBOutlet weak var lbl_btn_sing: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApp()
        overrideUserInterfaceStyle = .light
    }
    func configureApp() {
        view_btn_log.backgroundColor = UIColor(red:0.71, green:0.82, blue:0.60, alpha:1.0)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        logIn = storyboard.instantiateViewController(withIdentifier: "login")
        register = storyboard.instantiateViewController(withIdentifier: "register")
        activeViewController = logIn
    }
    
    @IBAction func ac_log(_ sender: Any) {
        view_btn_log.backgroundColor = UIColor(red:0.71, green:0.82, blue:0.60, alpha:1.0)
        view_btn_sing.backgroundColor = UIColor.white
        activeViewController = logIn
    }
    
    @IBAction func ac_sing(_ sender: Any) {
        view_btn_sing.backgroundColor = UIColor(red:0.71, green:0.82, blue:0.60, alpha:1.0)
        view_btn_log.backgroundColor = UIColor.white
        activeViewController = register
    }
    private var activeViewController : UIViewController?{
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    private func updateActiveViewController() {
        if let activeVC = activeViewController {
            addChild(activeVC)
            activeVC.view.frame = contentVC.bounds
            contentVC.addSubview(activeVC.view)
            activeVC.didMove(toParent: self)
        }
    }
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inactiveVC = inactiveViewController {
            inactiveVC.willMove(toParent: nil)
            inactiveVC.view.removeFromSuperview()
            inactiveVC.removeFromParent()
        }
    }
   
}
