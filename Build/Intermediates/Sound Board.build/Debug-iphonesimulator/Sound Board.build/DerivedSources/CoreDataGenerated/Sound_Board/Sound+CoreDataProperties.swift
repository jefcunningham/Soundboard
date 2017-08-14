//
//  Sound+CoreDataProperties.swift
//  
//
//  Created by Jef Cunningham on 8/13/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Sound {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sound> {
        return NSFetchRequest<Sound>(entityName: "Sound")
    }

    @NSManaged public var audio: NSData?
    @NSManaged public var name: String?

}
