//
//  ViewController.swift
//  supersecureapp
//
//  Created by David Fekke on 3/6/19.
//  Copyright © 2019 David Fekke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTextView: UITextView!
    let filename = "filewithdates.txt"
    
    override func viewDidLoad() {

        super.viewDidLoad()
        supersecureappGDiOSDelegate.sharedInstance.rootViewController = self;
                                 
    }

    @IBAction func writeToFilesystem(_ sender: Any) {
        let date = Date()
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        let currentDate = dateFormatter.string(from: date)
        
        let fm = GDFileManager.default()
        var documentsDirectoryURL = GDFileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dateData = currentDate.data(using: .unicode)
        documentsDirectoryURL.appendPathComponent(filename)
        print(documentsDirectoryURL)
        print("Test")
        fm.createFile(atPath: documentsDirectoryURL.path, contents: dateData, attributes: nil)
    }
    
    @IBAction func readFromFilesystem(_ sender: Any) {
        let fm = GDFileManager.default()
        var documentsDirectoryURL = GDFileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        documentsDirectoryURL.appendPathComponent(filename)
        if let filecontents = fm.contents(atPath: documentsDirectoryURL.path) {
            myTextView.text = String(bytes: filecontents, encoding: .unicode)
        }
    }
    

}

