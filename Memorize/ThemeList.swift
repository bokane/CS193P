//
//  ThemeList.swift
//  Memorize
//
//  Created by Bo Kane on 3/16/21.
//

import Foundation
import SwiftUI

let halloween = Theme<String>(themeName: "Spooky", themeColor: Color.orange, numCards: 3, themeEmojis: ["🎃","👻", "🕷", "👺", "🕸", "👹", "😈", "⻤", "🍭", "🍫", "🍬", "🦹🏻‍♂️"])

let animals = Theme<String>(themeName: "Nature", themeColor: Color.green, numCards: 3, themeEmojis: ["🐭","🦊", "🐧", "🐹", "🐻", "🐮", "🐯", "🐸", "🐞", "🐌", "🪲", "🦉"])

let sports = Theme<String>(themeName: "Ballz", themeColor: Color.purple, numCards: 3, themeEmojis: ["⚽️","🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🤿", "⛳️"])

let fruits = Theme<String>(themeName: "Fruit", themeColor: Color.red, numCards: 3, themeEmojis: ["🍎","🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🥝"])

let takeout = Theme<String>(themeName: "Seamless", themeColor: Color.red, numCards: 3, themeEmojis: ["🍣","🍱", "🍙", "🌯", "🥗", "🍕", "🌭", "🍔", "🥨", "🌮", "🥙", "🧆"])


var themeList = [animals, halloween, sports, fruits, takeout]
