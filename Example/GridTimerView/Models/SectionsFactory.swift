//
//  SampleSectionFactory.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 4/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit

struct SectionsFactory {
    
    static func generateSections() -> [Section] {
        
        let channels = [
            UIImage(named: "Channel Fox"),
            UIImage(named: "Channel Amc"),
            UIImage(named: "Channel Axn"),
            UIImage(named: "Channel Cnn"),
            UIImage(named: "Channel Hbo"),
            UIImage(named: "Channel Xd"),
            UIImage(named: "Channel Cnbc"),
            UIImage(named: "Channel Uni"),
            UIImage(named: "Channel Abc"),
            UIImage(named: "Channel History")
        ]
        
        let randomShows = [
            [
                ("The Mentalist", "Blood Money, Season 2 | Episode 19"),
                ("Bull", "Never Saw The Sign, Season 1 | Episode 7"),
                ("Prison Break", "Contingency, Season 5 | Episode 5"),
                ("American Dad", "Fight And Flight, Season 13 | Episode 2"),
                ("Family Guy", "Prick Up Your Ears, Season 6 | Episode 6"),
                ("Science of Stupid", "Episode 7, Season 4 | Episode 7"),
            ],
            [
                ("The Three Stooges", "Busy Buddies"),
                ("Men in Black", "Movies"),
                ("Better Call Saul", "Season 4, Episode 5"),
                ("Fear the Walking Dead", "Season 4, Episode 12"),
                ("The Rifleman", "Season 2, Episode 26"),
                ("Fantastic Four", "Movies"),
            ],
            [
                ("Killjoys", "Season 2, Episode 3"),
                ("BattleBots", "Season 2, Episode 11"),
                ("America's Got Talent", "Season 13, Episode 20"),
                ("Criminal Minds: Beyond Borders", "Season 2, Episode 4"),
                ("American Ninja Warrior", "Season 7, Episode 36"),
                ("Black List", "Episode 18"),
            ],
            [
                ("CNN Newsroom", "News"),
                ("Living Golf", "Sports"),
                ("World Sport", "Sports"),
                ("International Desk", "News"),
                ("Connect the World", "News"),
                ("Hala Gorani Tonight", "News"),
            ],
            [
                ("Shrek 2", "Movies"),
                ("The Full Monty", "Series"),
                ("Spy Kids", "Movies"),
                ("The Deuce: Au Reservoir", "Season 1 Episode 7"),
                ("Random Acts of Flyness", "Season 1 Episode 5"),
                ("Hard Knocks: Training Camp", "Season 1 Episode 5"),
            ],
            [
                ("Star vs. The Forces of Evil", "Game of Flags / Girls' Day Out"),
                ("Star Wars Rebels", "Steps into Shadow: Part 2"),
                ("Counterfeit Cat", "Hang In There/Wart Attack"),
                ("Looped", "Applecrab-Dabra/Monday Circles"),
                ("Grossology", "Candy Isn't Dandy"),
                ("Milo Murphy's Law", "The Little Engine That Couldn't"),
            ],
            [
                ("American Greed", "Online Dating Trap"),
                ("Suze Orman Security", "Suze Orman's Financial Security"),
                ("Retirement Income", "Learn The Secrets To Wall Street's Success"),
                ("Fast Money Halftime", "Fast Money Halftime Report"),
                ("Crisis", "Crisis On Wall Street"),
                ("Smokeless Grill", "Power Smokeless Grill"),
            ],
            [
                ("Noticiero univisión", "Programas / Magacín"),
                ("La rosa de guadalupe", "Programas / Matinal"),
                ("El rico y lázaro", "Programas / Magacín"),
                ("La bella y las bestias", "Programas / Debates"),
                ("La piloto", "7x04 - Un espetero hostelero"),
                ("Contacto deportivo", "13x19 - El Apu mas dulce"),
            ],
            [
                ("Celebrity Family Feud", "Celebrity contestants include Jeff Dunham"),
                ("Jimmy Kimmel Live", "Actor Jim Carrey; TV personality Andy Cohenl"),
                ("World News Tonight", "Roseanne Barr on the defense after show cancellation"),
                ("America This Morning", "Breaking news"),
                ("The View", "TV host Wendy Williams."),
                ("The Chew", "The crew celebrates its final show"),
            ],
            [
                ("American Pickers", "Hello Jell-O"),
                ("Ancient Aliens", "Earth Station Egypt"),
                ("Ice Road Truckers", "Into the Fire"),
                ("Yukon Gold", "Strike While the Iron Is Hot"),
                ("Forged In Fire", "Makraka"),
                ("Counting Cars", "Big Money Bike"),
            ]
        ]
        
        var sections = [Section]()
        for i in 0 ..< 10 {
            
            var items = [Item]()
            var date = Date.add(days: -1)
            for _ in 0 ..< 100 {
                let randomItem = randomShows[i][Int(arc4random_uniform(6))]
                let endDate = date.addingTimeInterval(TimeInterval(arc4random_uniform(100)))
                var item = Item()
                item.initTime = date
                item.endTime = endDate
                item.title = randomItem.0
                item.subtitle = randomItem.1
                items.append(item)
                date = endDate
            }
            
            var section = Section()
            section.items = items
            section.channelImage = channels[i]
            sections.append(section)
        }
        return sections
    }
}
