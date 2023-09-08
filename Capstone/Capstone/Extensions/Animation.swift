//
//  Animation.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 23.07.2023.
//

import Foundation
import SwiftUI

extension View {
    func withoutAnimation() -> some View {
        self.animation(nil, value: UUID())
    }
}
