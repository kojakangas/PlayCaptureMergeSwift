//
//  PlayVideoViewController.swift
//  VideoPlayRecord
//
//  Created by KOemxe on 1/8/17.
//  Copyright © 2017 KOemxe. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices

class PlayVideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    func startMediaBrowserFromViewController(viewController: UIViewController, usingDelegate delegate: protocol<UINavigationControllerDelegate, UIImagePickerControllerDelegate>) -> Bool {
        
        // check if our photo library is available, if not do nothing
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == false {
            return false
        }
        
        // set our image picker properties, be sure we only select movie formats
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeMovie as NSString as String]
        imagePicker.navigationBar.tintColor = UIColor.red
        imagePicker.navigationBar.barTintColor = UIColor.blue
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.delegate = delegate
        imagePicker.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName:UIColor.red]
        
        //now present the image picker and exit function
        self.present(imagePicker, animated: true, completion: nil)
        return true
    }
    
    @IBAction func playVideo(_ sender: Any) {
        
        startMediaBrowserFromViewController(viewController: self, usingDelegate: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UIImagePickerControllerDelegate
extension PlayVideoViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //get our media type
        let mediaType: NSString = info[UIImagePickerControllerMediaType] as! NSString
        
        //dismiss our image picker
        dismiss(animated: true) {
            // check if our file is a video file, and if so pass URL file reference and pass it to an instance of MPMoviePlayerViewController and play
            if mediaType == kUTTypeMovie {
                let moviePlayer = MPMoviePlayerViewController(contentURL: (info[UIImagePickerControllerMediaURL] as! NSURL) as URL! )
                self.presentMoviePlayerViewControllerAnimated(moviePlayer)
            }
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension PlayVideoViewController: UINavigationControllerDelegate {
    
}
