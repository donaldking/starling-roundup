protocol SingleInstanceProtocol: AnyObject {
    func someMethod()
}

class SingleInstanceImp: SingleInstanceProtocol {
    func someMethod() {
        // Do nothing
    }
}
