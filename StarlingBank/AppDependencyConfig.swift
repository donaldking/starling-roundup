import Foundation
import SBDependencyContainer
import SBNetworkInterface
import SBNetwork

enum AppDependencyConfig {
    static func configure() {
        // Regisgter starling bank networking component
        let sharedNetworking = SBNetwork.shared
        DC.shared.register(dependency: .singleInstance(sharedNetworking), for: SBNetworkInterface.self)
    }
}
