//
//  SectionTableViewControllerswift
//  HW3
//
//  Created by Alexey Efimov on 17.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

protocol ExpandableHederViewDelegate {
    func toggle(sectionIndex: Int)
}

class SectionTableViewController: UITableViewController {
    
    var sections = Section.getSections(persons: Person.getContactList())
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let section = sections[indexPath.section]
        var content = cell.defaultContentConfiguration()
        
        content.text = section.rows[indexPath.row]
        content.image = indexPath.row == 0
            ? UIImage(systemName: "phone")
            : UIImage(systemName: "tray")
        
        cell.contentConfiguration = content
                
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SectionTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        ExpandableHeaderView(title: sections[section].title, sectionIndex: section, delegate: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sections[indexPath.section].expended ? 44 : 0
    }
}

// MARK: - ExpandableHederViewDelegate
extension SectionTableViewController: ExpandableHederViewDelegate {
    func toggle(sectionIndex: Int) {
        
        sections[sectionIndex].expended.toggle()
        
        tableView.beginUpdates()
        
        for rowIndex in 0..<sections[sectionIndex].rows.count {
            let indexPath = IndexPath(row: rowIndex, section: sectionIndex)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        tableView.endUpdates()
    }
}
