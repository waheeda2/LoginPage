//
//  RegisterViewController.swift
//  LoginPage
//
//  Created by  Waheeda Dudekula on 14/03/23.
//  Copyright © 2023  Waheeda Dudekula and Sai Varshith. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, PersonDetailsDelegate {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var editViewController: EditViewController?
    
    var userNameText: String?
    var firstNameText: String?
    var lastNameText: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userName.text = userNameText
        
        
        firstName.text = UserDefaults.standard.string(forKey: "firstnametextstore")
        lastName.text = UserDefaults.standard.string(forKey: "lastnametextstore")
        dateOfBirth.text = UserDefaults.standard.string(forKey: "dateofbirthtextstore")
        if let imageData = UserDefaults.standard.object(forKey: "userPicture") as? Data, let image = UIImage(data: imageData){
            profileImage.image = image
        }
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.contentMode = .scaleAspectFill
        profileImage.backgroundColor = .gray
        
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(onClickEdit))
        
    }
    
    @objc func onClickEdit(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(identifier: "EditViewControllerID") as! EditViewController
        viewController.sendDelegate = self
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func sendPersonDetails(firstnametext: String?, lastnametext: String?, dateofbirthtext: String?) {
        firstName.text = firstnametext
        lastName.text = lastnametext
        dateOfBirth.text = dateofbirthtext
        
        if let imageData = UserDefaults.standard.object(forKey: "userPicture") as? Data, let image = UIImage(data: imageData){
            profileImage.image = image
        }
    }
    
}
