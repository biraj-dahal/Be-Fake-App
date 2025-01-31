//
//  LogInViewController.swift
//  BeFake App
//
//  Created by Biraj Dahal on 1/30/25.
//

import UIKit
import ParseSwift

class LogInViewController: UIViewController {

    @IBOutlet weak var beRealLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func didTapLogInButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        beRealLabel.textColor = .white
        

        // Do any additional setup after loading the view.
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "SignUpSegue" {
//            guard let destinationVC = segue.destination as? SignUpViewController else { return }
//            destinationVC.title = "Hello"
//        }
//    }
//    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
