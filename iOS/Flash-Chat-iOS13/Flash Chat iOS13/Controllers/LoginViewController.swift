//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {
  
  @IBOutlet weak var emailTextfield: UITextField!
  @IBOutlet weak var passwordTextfield: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.configureWithOpaqueBackground()
    navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    navBarAppearance.backgroundColor = UIColor(named: K.BrandColors.blue)
    navigationItem.standardAppearance = navBarAppearance
    
  }
  
  @IBAction func loginPressed(_ sender: UIButton) {
    if let email = emailTextfield.text, let password = passwordTextfield.text {
      Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        if let e = error {
          print(e.localizedDescription)
        } else {
          self.performSegue(withIdentifier: K.loginSegue, sender: self)
        }
      }
    }
  }
}
