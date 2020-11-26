//
//  ViewController.swift
//  MemeMe
//
//  Created by Tunde Ola on 11/26/20.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var photoLibraryButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!

//    let memeTextAttributes: [NSAttributedString.Key: Any] = [
//        NSAttributedString.Key.strokeColor: UIColor(named: "red") ?? "red",
//        NSAttributedString.Key.foregroundColor: "white",
//        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
//        NSAttributedString.Key.strokeWidth:  2.4
//    ]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
//        bottomTextField.defaultTextAttributes = memeTextAttributes
//        topTextField.defaultTextAttributes = memeTextAttributes
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bottomTextField.delegate = self
        topTextField.delegate = self
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
//        view.frame.origin.y -= getKeyboardHeight(notification)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    @IBAction func pickImageFromPhotoLibrary(_ sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }

    @IBAction func pickImageFromCamera(_ sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}

