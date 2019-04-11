
protocol Coordinator:class {
    var childCoordinators: [Coordinator] { get set }    
    func start()
}
