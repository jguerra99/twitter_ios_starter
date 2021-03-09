//
//  TweetViewController.swift
//  Twitter
//
//  Created by Jose Lopez on 3/9/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var tweetTextView: UITextView!

    
    @IBOutlet weak var counterLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tweetTextView.delegate = self
        tweetTextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
        let characterLimit = 280
        let newTweet = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        let characters:Int = characterLimit - newTweet.count
        counterLabel.text = String(characters) + "/280"
        
       
        return newTweet.count <= characterLimit
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
