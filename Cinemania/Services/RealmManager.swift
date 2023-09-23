import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    let realm = try? Realm()
    
    
}
