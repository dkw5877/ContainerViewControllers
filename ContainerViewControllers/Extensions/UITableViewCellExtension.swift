import UIKit

extension UITableViewCell : ReusableView { }

extension UITableViewCell {
    func configure(viewModel:ItemViewModel){
        selectionStyle = .none
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.albumId
        loadImage(url: viewModel.thumbnailUrl)
    }
    
    func loadImage(url:String) {
        let url = URL(string: url)!
        let resource = Resource<UIImage>(url: url, parse: { (data) -> UIImage? in
            let image = UIImage(data: data)
            return image
        })
        
        let imageLoader = ImageLoader.init(resource: resource)
        imageLoader.loadImage { (image) in
            DispatchQueue.main.async {
              self.imageView?.image =  image
              self.setNeedsLayout()
            }
        }
    }
}
