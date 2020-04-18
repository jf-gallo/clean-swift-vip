//
//  Parser.swift
//  jogo-ios
//
//  Created by Juan Felipe Gallo on 11/25/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

final class JSONSerializer {
    
    func isArrayData(data: Data?) -> Bool {
         
         do {
             // make sure this JSON is in the format we expect
             if let _ = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                 return false
             } else {
                 return true
             }
             
         } catch let error as NSError {
             print("Failed to load: \(error.localizedDescription)")
             
             JSONizeArrayResponse(data: data)
         }
         
         return true
     }
     
    func JSONizeSingleResponse(data: Data?) {
         
         do {
             // make sure this JSON is in the format we expect
             if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                 
                 print("Received single Yeison", json)
             }
         } catch let error as NSError {
             print("Failed to load: \(error.localizedDescription)")
             
             JSONizeArrayResponse(data: data)
         }
     }
     
    @discardableResult func JSONizeArrayResponse(data: Data?) -> [Dictionary<String, Any>]?  {
         
         do {
             // make sure this JSON is in the format we expect
             if let jsonArray = try JSONSerialization.jsonObject(with: data!, options: []) as? [Dictionary<String, Any>] {
                 
                print("Received Array Yeison", jsonArray)
                return jsonArray
                
             }
         } catch let error as NSError {
             print("Failed to load: \(error.localizedDescription)")
         }
        
        return nil
     }
    
}
