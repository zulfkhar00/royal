//
//  String.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 09/09/2023.
//

import Foundation

extension String {
    
    var removingHTMLOccurance: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
    
}
