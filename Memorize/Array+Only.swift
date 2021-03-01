//
//  Array+Only.swift
//  Memorize
//
//  Created by Bo Kane on 2/28/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
