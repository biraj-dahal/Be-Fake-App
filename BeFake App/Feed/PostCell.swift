//
//  PostCell.swift
//  BeFake App
//
//  Created by Biraj Dahal on 1/30/25.
//

import UIKit
import ParseSwift
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {


    @IBOutlet weak var nameAvatarLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationHoursLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postCaptionLabel: UILabel!
    
    private var imageDataRequest: DataRequest?
    

    func configure(with post: Post){
        if let user = post.user {
            nameLabel.text = user.username
            nameAvatarLabel.text = user.userInitials
        }
        if let imageFile = post.image,
            let imageURL = imageFile.url {
            imageDataRequest = AF.request(imageURL).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    self?.postImageView.image = image
                case .failure(let error):
                    print("Error downloading image: \(error)")
                    break
                }
                
            }
        }
        postCaptionLabel.text = post.caption
        locationHoursLabel.text = "Washington DC, 5 hrs ago"
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        postImageView.image = nil

        imageDataRequest?.cancel()

    }

}
