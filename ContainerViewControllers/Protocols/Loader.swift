
import Foundation

protocol Loader {
    
    associatedtype Kind
    associatedtype Model

    init(resource:Kind)
    func loadData(completion:@escaping ((Model?) -> ()) )
}
