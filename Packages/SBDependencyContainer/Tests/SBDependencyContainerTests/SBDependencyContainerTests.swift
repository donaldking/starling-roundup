import XCTest
@testable import SBDependencyContainer

final class SBDependencyContainerTests: XCTestCase {
    func test_register_singleInstance_registers_and_resolves_correct_single_instance() {
        let instance = SingleInstanceImp()
        DC.shared.register(dependency: .singleInstance(instance), for: SingleInstanceProtocol.self)
        let resolvedInstance = DC.shared.resolve(dependency: .singleInstance, for: SingleInstanceProtocol.self)
        XCTAssert(resolvedInstance === instance)
    }
    
    func test_register_closure_registers_and_resolves_correct_closure() {
        let closure: () -> ClosureProtocol = { ClosureImp() }
        DC.shared.register(dependency: .closure(closure), for: ClosureProtocol.self)
        let resolvedClosure = DC.shared.resolve(dependency: .closure, for: ClosureProtocol.self)
        XCTAssert(resolvedClosure is ClosureImp)
    }
    
    func test_register_closure_that_depends_on_another_closure_registers_and_resolves_correctly() {
        // Test to avoid a deadlock
        let closure: () -> ClosureProtocol = { ClosureImp() }
        DC.shared.register(dependency: .closure(closure), for: ClosureProtocol.self)
        let anotherClosure: () -> AnotherDepProtocol = {
            let service = DC.shared.resolve(dependency: .closure, for: ClosureProtocol.self)
            let anotherClosure = AnotherDepImp(service: service)
            return anotherClosure
        }
        DC.shared.register(dependency: .closure(anotherClosure), for: AnotherDepProtocol.self)
        let resolvedAnotherDep = DC.shared.resolve(dependency: .closure, for: AnotherDepProtocol.self)
        XCTAssert(resolvedAnotherDep is AnotherDepImp)
    }
}
