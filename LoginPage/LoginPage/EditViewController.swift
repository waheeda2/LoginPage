//
//  EditViewController.swift
//  LoginPage
//
//  Created by Sai Varshith on 14/03/23.
//  Copyright © 2023 Sai Varshith. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setDatePickerAsInputViewFor(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y:0.0, width: screenWidth, height: 200.0))
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 40.0))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapCancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: selector)
        toolbar.setItems([cancel, flexibleSpace, done], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}

protocol PersonDetailsDelegate: class {
    func sendPersonDetails(firstnametext: String?, lastnametext: String?, dateofbirthtext: String?)
}

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    weak var sendDelegate: PersonDetailsDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        navigationItem.title = "Edit Profile"

        self.dateOfBirth.setDatePickerAsInputViewFor(target: self, selector: #selector(dateSelected))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(addTapped))
        
        if let imageData = UserDefaults.standard.object(forKey: "userPicture") as? Data, let image = UIImage(data: imageData){
            profileImage.image = image
        }
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.contentMode = .scaleAspectFill
        profileImage.backgroundColor = .gray
        
    }
    
    @objc func addTapped() {
        sendDelegate?.sendPersonDetails(firstnametext: firstName.text, lastnametext: lastName.text, dateofbirthtext: dateOfBirth.text)
        UserDefaults.standard.set(firstName.text, forKey: "firstnametextstore")
        UserDefaults.standard.set(lastName.text, forKey: "lastnametextstore")
        UserDefaults.standard.set(dateOfBirth.text, forKey: "dateofbirthtextstore")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dateSelected() {
        if let datePicker = self.dateOfBirth.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.dateOfBirth.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateOfBirth.resignFirstResponder()
    }
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func onClickUpload(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.contentMode = .scaleAspectFit
            profileImage.image = pickedImage
        }
        
        if let pngRepresentation = profileImage.image?.pngData() {
            UserDefaults.standard.set(pngRepresentation, forKey: "userPicture")
        }
//        guard let data = UIImage("")?.jpegData(compressionQuality: 0.5) else {return}
//        let encoded = try! PropertyListEncoder().encode(data)
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
