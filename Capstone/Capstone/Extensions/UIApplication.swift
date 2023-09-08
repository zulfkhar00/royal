//
//  UIApplication.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 24.07.2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
