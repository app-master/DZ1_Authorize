//
//  LoginViewController.swift
//  DZ1_Authorize
//
//  Created by user on 05/03/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: --Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: --KeyboardNotifications
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowNotif),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHideNotif),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    

    @objc func keyboardWillShowNotif(_ notification: Notification) {
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.height)
    }
    
    @objc func keyboardWillHideNotif(_ notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
    
    // MARK: --UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if userNameField.isFirstResponder {
            passwordField.becomeFirstResponder()
        } else {
            passwordField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.errorLabel.alpha = 0
    }
    
    
    // MARK: --Actions
    @IBAction func loginPressed(_ sender: UIButton) {
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func forgotUserNamePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "pushToHomeVC", sender: sender)
    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "pushToHomeVC", sender: sender)
    }
    
    // MARK: --Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToHomeVC" {
           let hvc = segue.destination as! HomeViewController
           let button = sender as! UIButton
           hvc.text = button.titleLabel?.text ?? ""
        } else if segue.identifier == "showHomeVC" {
            let hvc = segue.destination as! HomeViewController
            hvc.text = "Привет" + " " + "\(userNameField.text!)!"
            hvc.title = userNameField.text
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "showHomeVC" {
            if userNameField.text == "Sergey" && passwordField.text == "12345" {
                return true
            } else {
                self.errorLabel.alpha = 1
                return false
            }
        }
        
        return true
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        
        guard unwindSegue.identifier == "UnwindSegue"  else { return }
        
        let hvc = unwindSegue.source as! HomeViewController
        photoImageView.image = hvc.image
        
    }
    
    
}
