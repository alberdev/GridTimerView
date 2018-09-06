//
//  SampleSectionFactory.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 4/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import Foundation

struct SectionsFactory {
    
    static func generateSections() -> [Section] {
        
        var sections = [Section]()
        for _ in 0 ..< 20 {
            
            var items = [Item]()
            var date = Date.add(days: -1)
            for _ in 0 ..< 100 {
                let randomItems: [(String, String)] = [
                    ("Espejo público", "Programas / Magacín"),
                    ("Torres en la cocina", "Programas / Matinal"),
                    ("Ya es mediodía", "Programas / Magacín"),
                    ("Al rojo vivo", "Programas / Debates"),
                    ("La que se avecina", "7x04 - Un espetero hostelero"),
                    ("Los simpsons", "13x19 - El Apu mas dulce"),
                ]
                let randomItem = randomItems[Int(arc4random_uniform(6))]
                let endDate = date.addingTimeInterval(TimeInterval(arc4random_uniform(100)))
                var item = Item()
                item.initTime = date
                item.endTime = endDate
                item.title = randomItem.0
                item.subtitle = randomItem.1
                items.append(item)
                date = endDate
            }
            
            let section = Section(items: items)
            sections.append(section)
        }
        return sections
    }
}
