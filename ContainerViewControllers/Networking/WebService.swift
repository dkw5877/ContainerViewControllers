import UIKit

final class WebService {

    private var session:URLSessionDataTask?

    //generic load method takes a Resource and a completion clousure
    func load<A>(resource:Resource<A>, completion: @escaping  (A?) -> ()) {

        session = URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            // this option makes the code a litte more clear in terms of what is happening
            //            guard let data = data else { completion(nil); return }
            //            completion(resource.parse(data)) //call completion with parsed resource

            //use flatMap to produce either a nil result or a parsed result
            let result = data.flatMap(resource.parse)
            completion(result)
        }

        self.session?.resume()
        
    }

    func cancel() {
        session?.cancel()
    }
}
