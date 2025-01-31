//
//  PostViewController.swift
//  BeFake App
//
//  Created by Biraj Dahal on 1/30/25.
//

import UIKit
import PhotosUI
import ParseSwift

class PostViewController: UIViewController{
    

    @IBOutlet weak var postButton: UIBarButtonItem!
    
    @IBOutlet weak var captionTextField: UITextField!
    
    @IBOutlet weak var selectPhotoButton: UIButton!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    private var imagePicked: UIImage?
    
    
    @IBAction func didTapPostButton(_ sender: Any) {
        view.endEditing(true)
        
        guard let image = imagePicked,
        let imageData = image.jpegData(compressionQuality: 0.1)
        else {
            return
        }
        
        let imageFile = ParseFile(name: "image.jpg", data: imageData)
        
        var post = Post()
        post.image = imageFile
        post.caption = captionTextField.text
        post.user = User.current
        
        post.save { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let savedPost):
                    print("Saved post successfuly: \(savedPost)")
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    self?.showUnknownErrorAlert(description: error.localizedDescription)
                
                }
            }
        }
        
    }
    
    @IBAction func didTapSelectPhotoButton(_ sender: Any) {
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        config.preferredAssetRepresentationMode = .current
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
        
        
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
    
    
    @IBAction func didTapViewArea(_ sender: Any) {
        view.endEditing(true)
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

extension PostViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let provider = results.first?.itemProvider,
              provider.canLoadObject(ofClass: UIImage.self) else {
                return
        }
        
        provider.loadObject(ofClass: UIImage.self) { [weak self] obj, error in
            guard let image = obj as? UIImage? else {
                self?.showUnknownErrorAlert(description: error?.localizedDescription)
                return
            }
            
        if let error = error {
                self?.showUnknownErrorAlert(description: error.localizedDescription)
            return
            }else {
                DispatchQueue.main.async {
                    self?.postImageView.image = image
                    self?.imagePicked = image
                }
        }
            
            
        }
    }
    
    
}
