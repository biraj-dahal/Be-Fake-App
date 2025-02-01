//
//  FeedViewController.swift
//  BeFake App
//
//  Created by Biraj Dahal on 1/30/25.
//

import UIKit
import ParseSwift
import PhotosUI

class FeedViewController: UIViewController {
    
    
    
    @IBOutlet weak var seeFriendsButton: UIBarButtonItem!
    
    @IBOutlet weak var feedTableView: UITableView!
    
    private  var posts: [Post] = [] {
        didSet {
            feedTableView.reloadData()
        }
    }
    
    private let refreshControl = UIRefreshControl()
    private var activityIndicator: UIActivityIndicatorView!

    
    // Pagination
    private var isLoadingMorePosts = false
    private var currentPage = 0
    private let postsPerPage = 10 // pagination size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        feedTableView.backgroundColor = .black
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.allowsSelection = false
        setupRefreshControl()
        
        
        // Initialize the activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white  // Make it white for visibility on black background
        activityIndicator.center = feedTableView.center
        activityIndicator.hidesWhenStopped = true
        feedTableView.addSubview(activityIndicator)

    }
    private func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            feedTableView.refreshControl = refreshControl
        } else {
            feedTableView.addSubview(refreshControl)
        }
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
    }

    @objc private func refreshFeed() {
        currentPage = 0
        queryPosts(refreshing: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        queryPosts()
        
    }
    
    private func queryPosts(refreshing: Bool = false) {
        // Show the activity indicator before starting the query
        activityIndicator.startAnimating()
        if isLoadingMorePosts{return}
        
        isLoadingMorePosts = true
        
        let query = Post.query().include("user").order([.descending("createdAt")]).limit(postsPerPage).skip(currentPage * postsPerPage)
        
        query.find { [weak self] result in
            DispatchQueue.main.async {
                            self?.refreshControl.endRefreshing() // Step 4: Stop refreshing
                            self?.activityIndicator.stopAnimating() // Stop the activity indicator when done
                        }
            switch result{
            case .success(let posts):
                if refreshing {
                                    self?.posts = posts // Reset the posts array when refreshing
                                } else {
                                    self?.posts.append(contentsOf: posts) // Append new posts to existing array
                                }
                                self?.currentPage += 1
                
            case .failure(let error):
                self?.showUnknownErrorAlert(description: error.localizedDescription)
            }
            self?.isLoadingMorePosts = false
            }
        }
    
    @IBAction func didTapLogOutButton(_ sender: Any) {
        print("Log out Button Pressed.")
        showConfirmLogoutAlert()
    }
    
    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @IBAction func didTapSeeFriendsButton(_ sender: Any) {
        print("Did Tap See Friends Button will be configured later")
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

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellReuse", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.configure(with: posts[indexPath.row])
        return cell
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let contentHeight = scrollView.contentSize.height
            let offset = scrollView.contentOffset.y
            let height = scrollView.frame.size.height
            
            // Check if the user has reached the bottom of the table
            if offset > contentHeight - height - 50 { // 50 is a buffer value
                // Fetch more posts if we're not already loading more
                if !isLoadingMorePosts {
                    queryPosts()
                }
            }
        }
}
