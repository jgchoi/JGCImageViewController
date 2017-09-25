//
//  ViewController.swift
//  JGCImageViewExample
//
//  Created by Jung Geon Choi on 2017-09-25.
//  Copyright © 2017 Jung Geon Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func fromTextButton(_ sender: UIButton) {
        present(image: #imageLiteral(resourceName: "cute"))
    }
    
    @IBAction func fromImageView(_ sender: UIButton) {
        present(imageView.image!, from: imageView)
    }
    
    @IBAction func fromImageButton(_ sender: UIButton)
    {
        present((sender.imageView?.image!)!, from: sender)
    }
    
}

