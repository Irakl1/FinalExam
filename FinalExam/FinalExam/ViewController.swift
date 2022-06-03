//
//  ViewController.swift
//  FinalExam
//
//  Created by Irakli Karanadze on 23.05.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var cityMallimage: UIImageView!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!

    let mailInputText = "irakli@mail.com"
    let passText = "karanadze"
    var error = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        mailTextField.layer.cornerRadius = 25
        passwordTextField.layer.cornerRadius = 25
        signinButton.layer.cornerRadius = 10
        
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        if mailTextField.text?.isEmpty == true {
            error = "შეიყვანეთ სწორი იმეილი"
            showAlert()
        }else if passwordTextField.text?.isEmpty == true {
            error = "შეიყვანეთ სწორი პაროლი"
            showAlert()
        }else {
            if mailTextField.text == mailInputText && passwordTextField.text == passText {
            }
        }
        
    }
    
    func showAlert () {
        let textAlert = UIAlertController(title: "Sign In", message: error, preferredStyle: UIAlertController.Style.alert)
        textAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!)  in
        }))
        present(textAlert, animated: true,completion: nil)
    }
}


