//
//  PostViewController.swift
//  BeFake App
//
//  Created by Biraj Dahal on 1/30/25.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postButton: UIBarButtonItem!
    
    @IBOutlet weak var captionTextField: UITextField!
    
    @IBOutlet weak var selectPhotoButton: UIButton!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    
    @IBAction func didTapPostButton(_ sender: Any) {
    }
    
    @IBAction func didTapSelectPhotoButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        // Do any additional setup after loading the view.
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
