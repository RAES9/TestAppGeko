//
//  Singleton.swift
//  TestApp
//
//  Created by Research Mobile on 10/17/19.
//  Copyright © 2019 Esteban Rivas. All rights reserved.
//

import UIKit

class Singleton{
    private init() {}
    static let instance = Singleton()
    //add variables
    var name = String()
    var username = String()
    var number = String()
}
