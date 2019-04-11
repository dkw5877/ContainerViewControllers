
final class ListLoader:Loader {
        
    private let webService = WebService()
    private let resource:Resource<[Album]>
    
    init(resource:Resource<[Album]>) {
        self.resource = resource
    }
    
    func loadData(completion: @escaping (([ItemViewModel]?) -> ())) {
        webService.load(resource: resource) { (items) in
            completion(items)
        }
    }
    
    public func loadItems(completion:@escaping (([ItemViewModel]?) -> ()) )  {
        webService.load(resource: resource) { (items) in
            completion(items)
        }
    }
    
}
