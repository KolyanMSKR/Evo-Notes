//
//  NotesListViewController.swift
//  EvoNote
//
//  Created by asd dsa on 5/10/19.
//  Copyright © 2019 Mykola Korotun. All rights reserved.
//

import UIKit
import CoreData

class NotesListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var notes = [Note]()
    
    var searchedNotes = [Note]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchRequest.fetchBatchSize = 20
        do {
            let notes = try PersistenceService.context.fetch(fetchRequest)
            self.notes = notes
            searchedNotes = self.notes
        } catch {
            fatalError("NotesListViewController + viewWillAppear")
        }
    }
    
    func pushNoteViewController(index: Int?, isNewNote: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NoteViewControllerID") as! NoteViewController
        
        controller.notes = notes
        controller.noteIndex = index
        controller.newNote = isNewNote
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - IBAction methods
    @IBAction func adNoteAction(_ sender: UIBarButtonItem) {
        pushNoteViewController(index: nil, isNewNote: true)
    }
    
    @IBAction func sortNotesAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Sort by text", style: .default, handler: { _ in
            self.sortBy(key: "text", asc: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Sort by date ASC", style: .default, handler: { _ in
            self.sortBy(key: "date", asc: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Sort by date DESC", style: .default, handler: { _ in
            self.sortBy(key: "date", asc: false)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

