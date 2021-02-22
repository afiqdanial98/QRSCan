//
//  ProspectsView.swift
//  QRScan
//
//  Created by Khirzeri on 23/06/2020.
//  Copyright © 2020 Unicorn. All rights reserved.
//

import CodeScanner
import SwiftUI
import UIKit
import Foundation
import CoreData


struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    let filter : FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "contacted"
        case .uncontacted:
            return "uncontacted"
            
        }
        
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted}
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted}
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(trailing:
                Button(action: {
                self.isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "xxx@gmail.com", completion: self.handleScan)
            }
        }
    }
    
    func handleScan (result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details [1]
            self.prospects.people.append(person)
        case .failure(let error):
            print ("scan failed")
        }
    }


}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
