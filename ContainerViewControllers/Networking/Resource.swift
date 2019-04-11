import Foundation

//generic resouce which takes a url and a parsing function
struct Resource<A> {
    let url:URL
    let parse:((Data) -> A?) //parsing clousure
}


/* we create an extension on resource to parse the json based on the provided closure */
extension Resource {

    init(url:URL, parseJSON:@escaping (Any) -> A? ) {
        self.url = url
        self.parse = { data in

            //parse json, if fails will return nil
            let json = try? JSONSerialization.jsonObject(with:data, options:[])
            return json.flatMap(parseJSON)
        }
    }
}


