//
//  ViewController.swift
//  CW
//
//  Created by kiran on 9/13/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    let baseUrl = "http://api.yeahviva.com/Events/getEventListingForWheel.json"
    let token:[String: Any] = ["token": "i3rq9jj9f2wy42bxldknnzr7o77pyzfi87yx0gjm"]
    
    var eventArray = [EventModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
         getData(fromUrl: baseUrl)
    }
    
    func getData(fromUrl: String){
        Alamofire.request(fromUrl, method: .post, parameters: token, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let responseData = response.result.value as? [String: Any]
            let dataOutput = responseData!["output"] as? [String: Any]
            let events = dataOutput!["response"] as? NSArray
                if events != nil {
                    for event in events!  {
                        self.eventArray.append(EventModal(eventJson: event as! NSDictionary))
                    }
                    DispatchQueue.main.async {
                        self.tblView.reloadData()
                    }
                    
            }
            }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(eventArray)
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TblCell {
         let event = eventArray[indexPath.row]
        cell.updateView(events: event)
        cell.eventImage.downloadImages(url: event.mainImage!)
        return cell
        }
        else {
            return TblCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailVC") as? EventDetailVC {
            let barButton = UIBarButtonItem()
            barButton.title = ""
            navigationItem.backBarButtonItem = barButton 
            vc.eventArray = eventArray
            vc.indePath = indexPath.row
           navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}

