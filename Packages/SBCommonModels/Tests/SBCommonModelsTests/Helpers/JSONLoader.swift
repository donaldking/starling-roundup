import Foundation

enum JSONLoaderError: Error {
    case fileNotFound
}

class JSONLoader {
    private init() {}

    static func loadJSON(from fileName: String) throws -> Data {
        guard let url = Bundle.module.url(forResource: fileName, withExtension: "json") else {
           // XCTFail("Missing file: \(fileName).json")
            throw JSONLoaderError.fileNotFound
        }
        return try! Data(contentsOf: url)
    }
}
