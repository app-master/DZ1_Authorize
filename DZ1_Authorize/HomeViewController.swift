//
//  HomeViewController.swift
//  DZ1_Authorize
//
//  Created by user on 05/03/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var text = ""
    var image = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        label.text = text
    }
    
    @IBAction func goToAction(_ sender: UIButton) {
        
        image = UIImage(named: "photo")!;
        
    }
    
}
