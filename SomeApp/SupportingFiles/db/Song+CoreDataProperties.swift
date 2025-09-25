import Foundation
import CoreData

@objc(Song)
public class Song: NSManagedObject {}

extension Song {
    
    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var artist: String
    @NSManaged public var lyrics: String

}

extension Song : Identifiable {}
