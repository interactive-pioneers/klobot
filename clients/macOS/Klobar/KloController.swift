//
//  KloController.swift
//  Klobar
//
//  Created by Angelo Cammalleri on 07.02.18.
//  Copyright © 2018 Interactive Pioneers GmbH. All rights reserved.
//

import Cocoa

enum KloState {
    case occupied
    case free
}

protocol KloControllerDelegate {
    func kloStateDidCHange(state: KloState)
}

struct Klo: Codable {
    let occupied: Int
}

class KloController {
    var delegate: KloControllerDelegate?
    
    let request = URLRequest(url: URL(string: "http://klobot/api")!)
    var timer: Timer = Timer()
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(KloController.performRequest), userInfo: nil, repeats: true)
    }
    
    @objc func performRequest() {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("No data?")
                return
            }

            guard let output =  String(data: data, encoding: String.Encoding.utf8) else {
                print("Failure to read data!")
                return
            }
            
            self.decodeJSON(string: output)
        }
        
        task.resume()
    }
    
    func decodeJSON(string: String) {
        guard let jsonData = string.data(using: .utf8) else {
            print("Parse error!")
            return
        }
        
        let decoder = JSONDecoder()
        let beer = try! decoder.decode(Klo.self, from: jsonData)
        let state: KloState = beer.occupied == 0 ? .free : .occupied
        
        delegate?.kloStateDidCHange(state: state)
    }
}
