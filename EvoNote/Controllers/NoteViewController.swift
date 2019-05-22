//
//  NoteViewController.swift
//  EvoNote
//
//  Created by asd dsa on 5/13/19.
//  Copyright © 2019 Mykola Korotun. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    
    var newNote: Bool?
    var notes: [Note]?
    var noteIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNoteText()
        getBarButtonItems()
    }
    
    func getBarButtonItems() {
        let shareBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonPressed))
        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        let editBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editNote))
        
        
        if newNote == true {
            navigationItem.rightBarButtonItems = [saveBarButton, shareBarButton]
        } else {
            navigationItem.rightBarButtonItems = [editBarButton, shareBarButton]
        }
    }
    
    @objc
    func shareButtonPressed() {
        if noteTextView.text.isEmpty {
            let message = "Put some text!"
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        
        let activityVC = UIActivityViewController(activityItems: [String(noteTextView.text)], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    func getNoteText() {
        guard let noteIndex = noteIndex, let notes = notes else { return }
        noteTextView.text = notes[noteIndex].text
    }
    
    @objc
    func saveNote() {
        if let text = noteTextView.text {
            let date = Date()
            let note = Note(context: PersistenceService.context)
            note.text = text
            note.date = date
            PersistenceService.saveContext()
            getBarButtonItems()
        }
    }
    
    @objc
    func editNote() {
        guard let noteIndex = noteIndex, let notes = notes else { return }
        notes[noteIndex].text = noteTextView.text
        PersistenceService.saveContext()
    }
}
