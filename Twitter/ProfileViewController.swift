//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Jose Lopez on 3/9/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var tweetArray = [NSDictionary]()
    var numberofTweet: Int!
 let myRefreshControl = UIRefreshControl()
    var profile = NSDictionary()
     
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var backdropView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tabcontrol: UISegmentedControl!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        profileTableView.refreshControl = myRefreshControl
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweets()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
         // #warning Incomplete implementation, return the number of sections
         return 1
     }
 
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         // #warning Incomplete implementation, return the number of rows
         return tweetArray.count
     }
          

   func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       if indexPath.row + 1 == tweetArray.count{
           loadMoreTweets()
       }
   }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "usertweetCell", for: indexPath) as! ProfileTableViewCell
       let user = tweetArray[indexPath.row]["user"] as! NSDictionary
     
       cell.usernameLabel.text = user["name"] as? String
     cell.tweetContentLabel.text = tweetArray[indexPath.row]["text"] as? String
       
   let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
       let data = try? Data(contentsOf: imageURL!)
       
       if let imageData = data{
           cell.profileImageView.image = UIImage(data: imageData)
       
       }
       cell.setFavorite(isFavorited: tweetArray[indexPath.row]["favorited"] as! Bool)
       cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
       cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
       
       return cell
   }
 
   func loadMoreTweets(){
       let myUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json"
       numberofTweet = numberofTweet + 20
       let myParams = ["count" : numberofTweet]
       TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
           
           self.tweetArray.removeAll()
           for tweet in tweets{
               self.tweetArray.append(tweet)
           }
           self.profileTableView.reloadData()
           
       }, failure: { (Error) in
           print("Could not retrieve tweets!")
       })
   }
   @objc func loadTweets(){
       numberofTweet = 20
       let myUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json"
       let myParams = ["count": 10]
       TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
           
           self.tweetArray.removeAll()
           for tweet in tweets{
               self.tweetArray.append(tweet)
           }
           self.profileTableView.reloadData()
           self.myRefreshControl.endRefreshing()
           
       }, failure: { (Error) in
           print("Could not retrieve tweets!")
       })
   }

    
    

    @IBAction func HomeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return tweetArray.count
//    }
            
           
            }

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



