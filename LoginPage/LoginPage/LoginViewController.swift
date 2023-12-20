//
//  LoginViewController.swift
//  LoginPage
//
//  Created by  Waheeda Dudekula on 14/03/23.
//  Copyright © 2023  Waheeda Dudekula and Sai Varshith. All rights reserved.
//


import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    var masterUserName: String = "Admin"
    var masterPassword: String = "admin123"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let value: Bool = UserDefaults.standard.bool(forKey: "IsAppLoggedIn")
      
        if value == true {
            //openRegisterViewScreen()
            openContentViewScreen()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userName.text = masterUserName
        password.text = masterPassword
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        userName.text?.removeAll()
        password.text?.removeAll()
    }

    @IBAction func onClickLogin(_ sender: Any) {
        if userName.text == "" || password.text == "" {
            showAlertWithTitle("Enter credentials")
            userName.text?.removeAll()
            password.text?.removeAll()
        } else if userName.text != masterUserName {
            showAlertWithTitle("UserName Not Found")
            userName.text?.removeAll()
        } else if password.text != masterPassword {
            showAlertWithTitle("Password Not Matching")
            password.text?.removeAll()
        }else {
            DispatchQueue.main.async {
                UserDefaults.standard.set(true, forKey: "IsAppLoggedIn")
                self.openContentViewScreen()
            }
        }
    }
    
    func openContentViewScreen() {
        if let contentViewController = self.storyboard?.instantiateViewController(identifier: "contentViewControllerID") as? ContentViewController {
            self.navigationController?.pushViewController(contentViewController, animated: true)
            UserDefaults.standard.set(masterUserName, forKey: "usernametextstore")
        }
    }
    
    func showAlertWithTitle(_ title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: false)
    }
    
}
