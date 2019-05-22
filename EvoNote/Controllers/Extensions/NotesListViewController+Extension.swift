//
//  File.swift
//  EvoNote
//
//  Created by asd dsa on 5/22/19.
//  Copyright © 2019 Mykola Korotun. All rights reserved.
//

import UIKit

extension NotesListViewController {
    func sortBy(key: String, asc: Bool) {
        self.fetchRequest.sortDescriptors = [NSSortDescriptor(key: key, ascending: asc)]
        do {
            let notes = try PersistenceService.context.fetch(self.fetchRequest)
            self.notes = notes
            self.searchedNotes = self.notes
        } catch {
            fatalError("NotesListViewController + sortBy")
        }
    }
}

extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        
        let date: Date = searchedNotes[indexPath.row].date
        
        cell.dateLabel.text = date.toString(dateFormat: "dd.MM.yy")
        cell.timeLabel.text = date.toString(dateFormat: "HH:mm")
        cell.noteTextLabel.text = searchedNotes[indexPath.row].text.truncatePrefix(length: 100)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushNoteViewController(index: indexPath.row, isNewNote: false)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            self.pushNoteViewController(index: indexPath.row, isNewNote: false)
        }
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (rowAction, indexPath) in
            print(indexPath.row)            
            
            PersistenceService.context.delete(self.notes[indexPath.row])
            self.notes.remove(at: indexPath.row)
            self.searchedNotes = self.notes
            PersistenceService.saveContext()
        }
        
        return [editAction, deleteAction]
    }
}

extension NotesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        
        if !searchText.isEmpty {
            searchedNotes = notes.filter({ (textNote) -> Bool in
                let tmp: NSString = textNote.text as NSString
                let range = tmp.range(of: searchText, options: .caseInsensitive)
                return range.location != NSNotFound
            })
        } else {
            searchedNotes = notes
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
