//
//  NetworkingLayer.swift
//  DispatchGroupsNetworkRequest
//
//  Created by Matthew Harrilal on 5/7/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit



func getPokemon() {
    let dispatchGroup = DispatchGroup()
    guard let url = URL(string: "http://pokeapi.co/api/v2/pokemon/3/") else {return}
    let session = URLSession.shared
    dispatchGroup.enter()
    session.dataTask(with: url) { (data, response, error) in
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: []) else {return}
            print("Started pokemon task")
            dispatchGroup.leave()
    }.resume()
    
    
    guard let kittenUrl = URL(string: "http://pokeapi.co/api/v2/pokemon/4/") else {return}
//    dispatchGroup.enter()
    session.dataTask(with: kittenUrl) { (data, response, error) in
        DispatchQueue.main.async(group: dispatchGroup) {
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: []) else {return}
            print("Started kitten task")
        }
        
//        dispatchGroup.leave()
    }.resume()
    
 
    dispatchGroup.wait()
    print("Done with tasks")
    
    
}



