
import UIKit

typealias JSONDictionary = [String:AnyObject]

class Album: ItemViewModel {
    var albumId: String = ""
    var title: String = ""
    var id: Int = 0
    var url:String = ""
    var thumbnailUrl: String = ""
}

extension Album {
    
    //failable initializer
    convenience init?(json:JSONDictionary) {
        self.init()
        //check for any required properties in json as needed
        guard let id = json["id"] as? Int else { return nil }
        self.id = id
        
        //check for and assign additional properties
        self.albumId = json["albumId"] as? String ?? ""
        self.title = json["title"] as? String ?? ""
        self.url = json["url"] as? String ?? ""
        self.thumbnailUrl = json["thumbnailUrl"] as? String ?? ""
    }
}

extension Album {
    static let all = Resource<[Album]>(url: URL(string: "https://jsonplaceholder.typicode.com/albums/1/photos")!) { (jsonData) -> [Album]? in
        //check we received json dictionaries
        guard let albums = jsonData as? [JSONDictionary] else { return nil }
        return albums.compactMap(Album.init)
    }

}
