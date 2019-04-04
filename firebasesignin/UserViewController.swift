//
//  UserViewController.swift
//  firebasesignin
//
//  Created by Joy Paul on 4/4/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var name: String!
    
    @IBOutlet weak var userName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userName.text = name
    }

}
