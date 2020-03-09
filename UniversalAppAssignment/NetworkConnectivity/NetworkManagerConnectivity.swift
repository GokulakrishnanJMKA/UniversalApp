//
//  RowsTableViewCell.swift
//  UniversalAppAssignment
//
//  Created by apple on 07/03/20.
//  Copyright © 2020 apple. All rights reserved.
//


import Foundation
import Alamofire

struct NetworkManagerConnectivity {
    static var networkManagerConnectivity: NetworkManagerConnectivity = NetworkManagerConnectivity()
    var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
     }
}


