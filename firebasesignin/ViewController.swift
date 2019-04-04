//
//  ViewController.swift
//  firebasesignin
//
//  Created by Joy Paul on 4/4/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import UIKit
import FirebaseAuth //for any auth we need
import FirebaseUI // to use the pre-made UI

class ViewController: UIViewController {
    
    var userInfo: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        signInUser()
    }
    
    //sets up the auth system to sign in/sign up the user
    func signInUser(){
        //init authUI
        let authUI = FUIAuth.defaultAuthUI()
        
        //if authUI is nil, log the error and display alert
        if authUI == nil{
            //log error
            return
        }
        
        //setting authUI's delegate to self
        authUI?.delegate = self
        
        //providers take the sign-in methods that we will use
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIEmailAuth()
        ]
        authUI?.providers = providers
        
        //init an access to the authUI VC
        let authViewController = authUI!.authViewController()
        
        //present the authUI VC so the user can log in
        present(authViewController, animated: true, completion: nil)
    }
    
}

//gotta extend FUIAuthDelegate so we can have some callback funcs
extension ViewController: FUIAuthDelegate{
    
    //this func is necessary for google and facebook signin
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }

    //this is the call back func after the user signs in, we can get basic user info here
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        
        //if error exits, log the error
        if error != nil{
            //log the error
            return
        }
        
        //if the user entity exists, proceed with getting the user info and re-direct user to a new VC
        if let user = user {
            let uDName = user.displayName
            userInfo = uDName as! String
            let email = user.email
            let photoURL = user.photoURL
            
            print("User name is -> \(uDName as! String), user email is \(email as! String), and user photourl is \(photoURL as! URL)")
            
            performSegue(withIdentifier: "loginTapped", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginTapped"{
            let destinationVC = segue.destination as! UserViewController
            
            destinationVC.name = userInfo
        }
    }

}

