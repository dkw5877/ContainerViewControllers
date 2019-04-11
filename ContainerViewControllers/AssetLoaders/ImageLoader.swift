
import UIKit.UIImage

final class ImageLoader:Loader {

    private let webService = WebService()
    private let resource:Resource<UIImage>
    
    init(resource:Resource<UIImage>) {
        self.resource = resource
    }
    
    func loadData(completion: @escaping ((UIImage?) -> ())) {
        webService.load(resource: resource) { (image) in
            completion(image)
        }
    }
    
    public func loadImage(completion:@escaping ((UIImage?) -> ()) )  {
        webService.load(resource: resource) { (image) in
            completion(image)
        }
    }
    
    class func imageLoader(urlString:String) -> ImageLoader? {
        guard let url = URL(string: urlString) else { return nil }
        let resource = Resource<UIImage>(url: url, parse: { (data) -> UIImage? in
            let image = UIImage(data: data)
            return image
        })
        
        return ImageLoader(resource: resource)
    }
}
