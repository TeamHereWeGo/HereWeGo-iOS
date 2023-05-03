//
//  Array+Extension.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2023/05/03.
//

import Foundation

extension Array {
    
    var oneAndOnly: Element? {
        count == 1 ? first : nil
    }
}

extension Array where Element: Identifiable {
    
    func index(of element: Element) -> Index? {
        firstIndex(where: { $0.id == element.id })
    }
}
