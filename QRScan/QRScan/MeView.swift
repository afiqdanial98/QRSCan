//
//  MeView.swift
//  QRScan
//
//  Created by Khirzeri on 23/06/2020.
//  Copyright © 2020 Unicorn. All rights reserved.
//
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@gmail.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField ( "Name" , text: $name)
                    .textContentType(.name)
                    .font(.title)
                    .padding(.horizontal)
                
                TextField("Email Add", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .padding([.horizontal, .bottom])
                
                Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Spacer()
            }
        .navigationBarTitle("you code here")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data (string.utf8)
        filter.setValue(data, forKey: "input")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage:cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle")  ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
