//
//  RecordVideoViewController.swift
//  VideoPlayRecord
//
//  Created by KOemxe on 1/8/17.
//  Copyright © 2017 KOemxe. All rights reserved.
//

import UIKit
import MobileCoreServices

class RecordVideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func video(videoPath: NSString, didFinishSavingWithError error: NSError?, contextInfo info: Any) {
        var title = "Success"
        var message = "Video was saved"
        if let _ = error {
            title = "Error"
            message = "Video failed to save"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func startCameraFromViewController(viewController: UIViewController, withDelegate delegate:protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) -> Bool {
        //check if camera is available, otherwise exit
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            let alert = UIAlertController(title: "Unavailable", message: "Camera is not available, you are likely running in the simulator!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        //now we set our camera and make sure it only records videos
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.mediaTypes = [kUTTypeMovie as NSString as String]
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        //now start our camera capture
        present(cameraController, animated: true, completion: nil)
        return true
    }
    
    @IBAction func recordVideo(_ sender: Any) {
        startCameraFromViewController(viewController: self, withDelegate:  self)
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

extension RecordVideoViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        dismiss(animated: true, completion: nil)
        //Handle a movie capture
        if mediaType == kUTTypeMovie {
            guard let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path else { return }
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path) {
                UISaveVideoAtPathToSavedPhotosAlbum(path, self, #selector(RecordVideoViewController.video(videoPath:didFinishSavingWithError:contextInfo:)), nil)
            }
        }
        
    }
    
}

extension RecordVideoViewController: UINavigationControllerDelegate {
    
}
