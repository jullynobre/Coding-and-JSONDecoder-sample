//
//  ViewController.swift
//  BlackCoffeeNSCoding
//
//  Created by Ada 2018 on 08/08/18.
//  Copyright © 2018 Academy 2018. All rights reserved.
//

import UIKit

struct Character: Codable{
    var name: String
    var status: String
    
    init(name: String, status: String) {
        self.name = name
        self.status = status
    }
    
    init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case status
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://rickandmortyapi.com/api/character/1")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error != nil {
                print(error!)
            }else {
                if let urlContent = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Character.self, from: urlContent)
                        
                        print(result)
                        
                    } catch {
                        print("JSON Processing Failed")
                    }
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

