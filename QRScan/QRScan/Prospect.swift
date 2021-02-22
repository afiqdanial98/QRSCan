//
//  Prospect.swift
//  QRScan
//
//  Created by Khirzeri on 23/06/2020.
//  Copyright © 2020 Unicorn. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable , Codable{
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}


class Prospects : ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
}
