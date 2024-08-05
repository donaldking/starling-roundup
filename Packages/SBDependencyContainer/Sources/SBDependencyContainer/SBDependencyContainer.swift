import Foundation

public typealias DC = SBDependencyContainer

public final class SBDependencyContainer {
    public static let shared = SBDependencyContainer()
    private var singleInstanceDependencies: [ObjectIdentifier: AnyObject] = [:]
    private var closureDendencies: [ObjectIdentifier: () -> Any] = [:]
    private let accessQueue = DispatchQueue(label: "com.sbdependency.container.access.queue", attributes: .concurrent)
    
    public func register(dependency type: RegistrationType, for interface: Any.Type) {
        // Prevent multiple writes from different threads, which could lead to race condition
        accessQueue.sync(flags: .barrier) {
            let objectIdentifier = ObjectIdentifier(interface)
            switch type {
            case .singleInstance(let instance):
                singleInstanceDependencies[objectIdentifier] = instance
            case .closure(let closure):
                closureDendencies[objectIdentifier] = closure
            }
        }
    }
    
    public func resolve<T>(dependency type: ResolverType, for interface: T.Type) -> T {
        var value: T!
        // Prevent returning result on our private thread
        accessQueue.sync {
            let objectIdentifier = ObjectIdentifier(interface)
            switch type {
            case .singleInstance:
                guard let instance = singleInstanceDependencies[objectIdentifier] as? T else { fatalError("Unable to resolve for interface: \(interface)")}
                value = instance
            case .closure:
                guard let closure =  closureDendencies[objectIdentifier],
                      let closureDependency = closure() as? T else { fatalError("Unable to resolve for interface: \(interface)")}
                value = closureDependency
            }
        }
        return value
    }
}
