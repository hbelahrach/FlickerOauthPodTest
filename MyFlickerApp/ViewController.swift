//
//  ViewController.swift
//  MyFlickerApp
//
//  Created by mac on 24/07/2016.
//  Copyright © 2016 mac. All rights reserved.

import UIKit
import OAuthSwift
typealias Payload = [String: AnyObject]


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doOAuthFlickr(){
        let oauthswift = OAuth1Swift(
            consumerKey: "20ed5454457c647f9d18fef1082ead96",
            consumerSecret: "71afb649cc32defb",
            requestTokenUrl: "https://www.flickr.com/services/oauth/request_token",
            authorizeUrl:    "https://www.flickr.com/services/oauth/authorize",
            accessTokenUrl:  "https://www.flickr.com/services/oauth/access_token"
        )
        oauthswift.authorizeWithCallbackURL( NSURL(string: "MyFlickerApp://oauth-callback/flickr")!, success: {
            credential, response, parameters in
            let user_id = parameters["user_nsid"]?.stringByReplacingOccurrencesOfString("%40", withString: "@")
            //self.showTokenAlert(serviceParameters["name"], credential: credential)
            self.testFlickr(oauthswift, consumerKey: "20ed5454457c647f9d18fef1082ead96", user_id: user_id!)
            }, failure: { error in
                print(error.localizedDescription)
        })
    }
    func testFlickr (oauthswift: OAuth1Swift, consumerKey: String, user_id: String) {
        let url :String = "https://api.flickr.com/services/rest/"
        let parameters :Dictionary = [
            "method"         : "flickr.photos.search",
            "api_key"        : consumerKey,
            "user_id"        : user_id,
            "format"         : "json",
            "nojsoncallback" : "1",
            "extras"         : "url_q,url_z"
        ]
        oauthswift.client.get(url, parameters: parameters,
                              success: {
                                data, response in
                                let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as! Payload
                                
                                print(jsonDict)
                                
                                var photos = jsonDict["photos"]!!["photo"] as! [Payload]
                                var photosTitles = [String]()
                                var photosDescription = [String]()
                                var urls = [String]()
                                
                                for element in photos {
                                    
                                    urls.append(element["url_q"] as! String)
                                    photosTitles.append(element["title"] as! String)
                                    photosDescription.append("description not available")
                                }
                                
                                print(urls)
                                print(photosDescription)
                                print(photosTitles)
                                
                                self.presentViewController(MyImages(PhotoTitles: photosTitles, PhotoDescriptions :photosDescription, urls :urls), animated: true, completion: nil)
            }, failure: { error in
                print(error)
        })
    }


}

