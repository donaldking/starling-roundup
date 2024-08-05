public class SBDynamicType<T> {
    public typealias Listener = (T) -> Void
    public var listener: Listener?
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    
    public init(value: T) {
        self.value = value
    }
    
    public func bind(callback: @escaping (T) -> Void) {
        self.listener = callback
    }
}
