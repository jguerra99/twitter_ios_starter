//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Jose Lopez on 3/9/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController{
  
    

    var tweetArray = [NSDictionary]()
    var numberofTweet: Int!
let myRefreshControl = UIRefreshControl()
    var profile = NSDictionary()
   
    @IBOutlet weak var backdropView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tabcontrol: UISegmentedControl!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text = profile["screen_name"] as? String
        let imageURL = URL(string: (profile["profile_image_url_https"] as? String)!)
            let data = try? Data(contentsOf: imageURL!)
            
            if let imageData = data{
                profileImageView.image = UIImage(data: imageData)
            
            }
        let backimageURL = URL(string: (profile["profile_banner_url"] as? String)!)
            let data1 = try? Data(contentsOf: backimageURL!)
            
            if let backimageData = data1{
                backdropView.image = UIImage(data: backimageData)
            
            }
        
//    print(profile)
        

    }

    
    
    
    

    @IBAction func HomeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    
            
           
            }

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



