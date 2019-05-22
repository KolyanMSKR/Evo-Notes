//
//  Note+CoreDataProperties.swift
//  EvoNote
//
//  Created by asd dsa on 5/11/19.
//  Copyright © 2019 Mykola Korotun. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var date: Date
    @NSManaged public var text: String

}
