//
//  ViewController.swift
//  foodtracker
//
//  Created by blackbeans on 7/14/15.
//  Copyright (c) 2015 blackbeans. All rights reserved.
//

import UIKit

class MealViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    var meal = Meal?()
    
    @IBOutlet weak var saveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        checkValidMealName()
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        let isPresentInAddMealMode =  presentedViewController is UINavigationController
        
        if isPresentInAddMealMode{
        dismissViewControllerAnimated(true, completion: nil)
        }else{
            //edit
            
            navigationController!.popViewControllerAnimated(true)
        
        }
        

    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func checkValidMealName(){
        let  val = nameTextField.text ?? ""
        saveButton.enabled = !val.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var  tmpSender =  sender as! UIBarButtonItem
        if saveButton == tmpSender{
            let  name = nameTextField.text ?? "空"
            let photo = photoImageView.image
            let rate = ratingControl.rating
            meal = Meal(name: name, photo: photo!, rating: rate)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //hidden keyboard
        textField.resignFirstResponder()
        return true
    }

    @IBAction func selectImage(sender: UITapGestureRecognizer) {

//        println("select Imager From Photo")
        
        nameTextField.resignFirstResponder()
        
        let imagePicker = UIImagePickerController()
        
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {

       let selectImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        photoImageView.image = selectImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

