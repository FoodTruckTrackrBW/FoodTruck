//
//  SignUpViewController.swift
//  FoodTruck
//
//  Created by Stephanie Ballard on 4/24/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit
import FirebaseAuth

typealias completion = Result<User?, Error>

class SignUpViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        Auth.auth().removeStateDidChangeListener(handle!)
        
    }
    
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
            else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { auth, error in
            if let error = error {
                print("Error creating account: \(error)")
            } else {
                if let auth = auth {
                    print("Success!!!")
                    print(auth.user.uid)
                    print(auth.user.email as Any)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func createAnAccount(email: String, password: String, completion: @escaping(completion) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                NSLog("Error creating User: \(error)")
                return
            }
            completion(.success(result?.user))
        }
    }
}
