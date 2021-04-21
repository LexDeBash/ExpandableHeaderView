//
//  Section.swift
//  HW3
//
//  Created by Alexey Efimov on 19.02.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

struct Section {
    let title: String
    let rows: [String]
    var expended: Bool
    
    static func getSections(persons: [Person]) -> [Section] {
        var sections: [Section] = []
        
        persons.forEach { person in
            let section = Section(
                title: person.fullName,
                rows: [person.phoneNumber, person.email],
                expended: false
            )
            sections.append(section)
        }
        
        return sections
    }
}
