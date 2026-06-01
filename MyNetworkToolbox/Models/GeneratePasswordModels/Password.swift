//
//  Password.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/30/26.
//

import Foundation

struct Password {
    var passwordString: String
}

enum PasswordLength: Int, CaseIterable {
    // available lengths from dinopass
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case eleven = 11
    case twelve = 12
    case thirteen = 13
    case fourteen = 14
    case fifteen = 15
    case sixteen = 16
    case seventeen = 17
    case eighteen = 18
    case nineteen = 19
    case twenty = 20
}
