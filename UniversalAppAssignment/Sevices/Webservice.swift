//
//  Webservice.swift
//  UniversalAppAssignment
//
//  Created by apple on 06/03/20.
//  Copyright © 2020 apple. All rights reserved.


import Foundation

class Webservice {
    
   func getRows(url: URL, completion: @escaping ([Row]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if data != nil {
                if let url = Bundle.main.url(forResource: ConstantData.universal, withExtension: ConstantData.json) {
//                let jsonData = ConstantData.JSON.data(using: .utf8)!
                    var jsonData = Data()
                    do {
                          jsonData = try Data(contentsOf: url)
                          // make sure this JSON is in the format we expect
                          if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any] {
                          // try to read out a string array
                            if let title = json[ConstantData.titleHead] as? String {
                            ConstantData.navigationTitle = title
                          }
                          if let rows = json[ConstantData.rows] as? [String:String] {
                            print(rows)
                          }
                       }
                    } catch let error as NSError {
                      print("Failed to load: \(error.localizedDescription)")
                }
                let rowList = try? JSONDecoder().decode(RowList.self, from: jsonData)
                if let rowList = rowList {
                    completion(rowList.rows)
                }
              }
           }
        }.resume()
        
    }
}
