//
//  SignUpViewController.swift
//  BeFake App
//
//  Created by Biraj Dahal on 1/30/25.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func didTapSignUpButton(_ sender: Any) {
        guard let username = usernameLabel.text,
                let email = emailLabel.text,
                let password = passwordLabel.text,
              !username.isEmpty,
              !email.isEmpty,
              !password.isEmpty
        else {
            self.showMissingFieldsAlert()
            return
        }
        
        var newUser = User()
        newUser.username = username
        newUser.password = password
        newUser.email = email
 
        newUser.signup { [weak self] result in
            switch result {
            case .success(let user):
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
            case .failure(let error):
                self?.showUnknownErrorAlert(description: error.localizedDescription)
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        // Do any additional setup after loading the view.
        
    }
    
    private func showUnknownErrorAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Sign Up", message: description ?? "An unknown error occurred.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Missing Fields", message: "Please fill in all fields", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
