import Foundation

public enum RegistrationType {
    case singleInstance(AnyObject)
    case closure(() -> Any)
}
