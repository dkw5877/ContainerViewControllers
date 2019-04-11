//
//import Foundation
//import UIKit.UIImage
//
//enum ResourceType {
//    case image
//    case list
//}
//
//class AssetLoaderBuilder {
//    
//    private var resourceType:ResourceType = .image
//    private var urlString:String = ""
//    
//    func withResource<T>(resource:Resource<T>) -> AssetLoaderBuilder {
//        self.resourceType = type
//        return self
//    }
//    
//    func withURLString(urlString:String) -> AssetLoaderBuilder {
//        self.urlString = urlString
//        return self
//    }
//    
//    func build() -> ImageLoader {
//        
//        let url = URL(string: urlString)!
//        
//        switch resourceType {
//        case .image:
//            let resource = Resource<UIImage>(url: url, parse: { (data) -> UIImage? in
//                let image = UIImage(data: data)
//                return image
//            })
//            return ImageLoader(resource: resource)
//        case .list:
//            let resource = Resource<[Album]>
//            return ListLoader(resource: resource)
//        }
//    }
//}
