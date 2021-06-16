//
//  ViewController.swift
//  CatOrDog
//
//  Created by Dzmitry Semenovich on 16.06.21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var takeImage: UIImageView!
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var classificationResultLabel: UILabel!
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takeImage.layer.masksToBounds = true
        takeImage.layer.borderWidth = 1.5
        takeImage.layer.borderColor = UIColor.systemBlue.cgColor
        takeImage.layer.cornerRadius = 20
    }
    
    func MLRequest() -> VNCoreMLRequest {
        
        var request: VNCoreMLRequest?
        
        do {
            let modelObj = try CatOrDog(configuration: MLModelConfiguration())
            let animalsModel = try VNCoreMLModel(for: modelObj.model)
            
            request = VNCoreMLRequest(model: animalsModel, completionHandler: { (request, error) in
                self.handleResult(request, error)
                
            })
            
        } catch {
            print("Unable to create a request!")
        }
        
        request?.imageCropAndScaleOption = .centerCrop
        
        return request!
    }
    
    func executeRequest(_ image: UIImage) {
        
        guard let ciImage = CIImage(image: image) else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let handler = VNImageRequestHandler(ciImage: ciImage)
            
            do {
                try handler.perform([self.MLRequest()])
            } catch {
                print("Failed to get the description")
            }
        }
    }
    
    func handleResult(_ request: VNRequest, _ error: Error?) {
        
        if let classificationResult = request.results as? [VNClassificationObservation] {
            
            DispatchQueue.main.async {
                self.classificationResultLabel.text = "This is a \(classificationResult.first!.identifier)"
            }
        }
        else {
            DispatchQueue.main.async {
                self.showAlertWith(title: "Unable to get the results", message: "")
            }
            print("Unable to get the results")
        }
        
    }
    @IBAction func classify(_ sender: Any) {
        if takeImage.image != nil {
            executeRequest(takeImage.image!)
        } else {
            self.classificationResultLabel.text = "Image doesn't exist"
            return
        }
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            
            showAlertWith(title: "Camera doesn't exist", message: "")
            return
        }
        
        selectImageFrom(.camera)
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        selectImageFrom(.photoLibrary)
    }
    
    func selectImageFrom(_ source: ImageSource) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[.originalImage] as? UIImage  else {
            print("IMage not found!")
            return
        }
        
        takeImage.image = selectedImage
    }
    
}

