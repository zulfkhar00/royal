//
//  XMarkButton.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 08.08.2023.
//

import SwiftUI

struct XMarkButton: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Button(action: {
            isPresented = false
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton(isPresented: .constant(false))
    }
}
