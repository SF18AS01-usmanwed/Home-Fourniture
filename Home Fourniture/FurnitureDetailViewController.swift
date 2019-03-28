//
//  FurnitureDetailViewController.swift
//  Home Fourniture
//
//  Created by Ousmane Ouedraogo on 3/27/19.
//  Copyright © 2019 Ousmane Ouedraogo. All rights reserved.
//

import UIKit

class FurnitureDetailViewController: UIViewController , UINavigationControllerDelegate,
UIImagePickerControllerDelegate{
    
    var furniture: Furniture?
    @IBOutlet weak var choosePhotoButton: UIButton!
    @IBOutlet weak var furnitureTitleLabel: UILabel!
    @IBOutlet weak var furnitureDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    func updateView() {
        guard let furniture: Furniture = furniture else {return;}
        if let imageData: Data = furniture.imageData,
            let image: UIImage = UIImage(data: imageData) {
            choosePhotoButton.setTitle("", for: .normal);
            choosePhotoButton.setImage(image, for: .normal);
        } else {
            choosePhotoButton.setTitle("Choose Image", for: .normal);
            choosePhotoButton.setImage(nil, for: .normal);
        }
        
        furnitureTitleLabel.text = furniture.name;
        furnitureDescriptionLabel.text = furniture.description;
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: Any) {
        let imagePicker: UIImagePickerController = UIImagePickerController();
        imagePicker.delegate = self;
        
        let alertController: UIAlertController = UIAlertController(
            title: "Choose Image Source",
            message: "Where do you want to get an image from?",
            preferredStyle: .actionSheet
        );
        
        
        //  MARK: In the handlers for your actions, set the corresponding source type on your image picker, and present the image picker.
        //            Right now, if you run the app on the Simulator and try to present the camera, the app will crash (since the Simulator has no camera). To avoid giving users the option to choose a source that doesn't exist, add an if statement before your image-picking actions to check whether or not the source type is available.
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) {(action: UIAlertAction) in
                imagePicker.sourceType = .camera;
                self.present(imagePicker, animated: true);
            }
            alertController.addAction(cameraAction);
        }
        
        if UIImagePickerController.isSourceTypeAvailable (.photoLibrary) {
            
            let photoLibraryAction: UIAlertAction = UIAlertAction(title: "Photo Library", style: .default) {(action: UIAlertAction) in
                imagePicker.sourceType = .photoLibrary;
                self.present(imagePicker, animated: true);
            }
            alertController.addAction(photoLibraryAction);
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel);
        alertController.addAction(cancelAction);
        
        alertController.popoverPresentationController?.sourceView = (sender as! UIView);
        present(alertController, animated: true);
        
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        
        var activityItems: [Any] = [Any]();
        
        guard let furniture: Furniture = furniture else {
            return;
        }
        
        if let data: Data = furniture.imageData,
            let image: UIImage = UIImage(data: data) {
            activityItems.append(image);
        }
        
        if !furniture.description.isEmpty {
            activityItems.append(description);
        }
        
        guard !activityItems.isEmpty else {
            return;
        }
        
        let activityController: UIActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil);
        
        
        present(activityController, animated: true);
    }
    
    // MARK: - UIImagePickerControllerDelegate
    // Page 683, step 2, bullet 5.
    // First column of dictionary should be of type UIImagePickerController.InfoKey
    // UIImagePickerControllerOriginalImage renamed UIImagePickerController.InfoKey.originalImage
    
    //    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
    //        //page 684, step 2, bullet 7
    //        guard let image: UIImage = info[UIImagePickerControllerOriginalImage]as? UIImage else {
    //            fatalError("could not get original image");
    //        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let image: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following")
        }
        
        
        guard let data: Data = image.pngData() else {
            fatalError("UIImagePNGRepresentation() returned nil");
        }
        
        guard furniture != nil else {
            fatalError("furniture = nil");
        }
        furniture?.imageData = data;   //page 684, step 2, bullet 8
        
        dismiss(animated: true, completion: {
            self.updateView();   //page 684, step 2, bullet 8
        });
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true);
    }
    
}
