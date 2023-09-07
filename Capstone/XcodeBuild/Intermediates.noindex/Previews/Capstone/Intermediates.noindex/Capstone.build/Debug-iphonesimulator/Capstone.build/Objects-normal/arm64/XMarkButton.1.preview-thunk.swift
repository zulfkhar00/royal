@_private(sourceFile: "XMarkButton.swift") import Capstone
import SwiftUI
import SwiftUI

extension XMarkButton_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Components/XMarkButton.swift", line: 26)
        XMarkButton()
    
#sourceLocation()
    }
}

extension XMarkButton {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Components/XMarkButton.swift", line: 15)
      Button(action: {
        presentationMode.wrappedValue.dismiss()
      }, label: {
        Image(systemName: __designTimeString("#9209.[1].[1].property.[0].[0].arg[1].value.[0].arg[0].value", fallback: "xmark"))
          .font(.headline)
      })
    
#sourceLocation()
    }
}

import struct Capstone.XMarkButton
import struct Capstone.XMarkButton_Previews

