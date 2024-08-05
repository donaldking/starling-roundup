protocol ClosureProtocol {
    func someClosure()
}

struct ClosureImp: ClosureProtocol {
    func someClosure() {
        // Do nothing
    }
}

protocol AnotherDepProtocol {
    func anotherSample()
}

struct AnotherDepImp: AnotherDepProtocol {
    let service: ClosureProtocol
    
    init(service: ClosureProtocol) {
        self.service = service
    }
    
    func anotherSample() {
        // Do nothing
    }
}
