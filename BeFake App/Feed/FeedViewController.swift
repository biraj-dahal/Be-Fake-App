//
//  FeedViewController.swift
//  BeFake App
//
//  Created by Biraj Dahal on 1/30/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    @IBOutlet weak var navItemBar: UINavigationItem!
    
    @IBOutlet weak var seeFriendsButton: UIBarButtonItem!
    
    @IBOutlet weak var postPhotoButton: UIButton!
    @IBOutlet weak var feedTableView: UITableView!
    
    @IBAction func didTapLogOutButton(_ sender: Any) {
    }
    
    @IBAction func didTapSeeFriendsButton(_ sender: Any) {
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
