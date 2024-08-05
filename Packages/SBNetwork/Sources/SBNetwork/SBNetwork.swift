import Foundation

public enum SBNetworkError: Error {
    case invalidURL
    case invalidResponse
    case encodingFailed
}

final public class SBNetwork {
    private let session: URLSession
    private var token: String?
    
    public init(session: URLSession = .shared, token: String? = nil) {
        self.session = session
        self.token = token
    }
    
    public func setToken(token: String) {
        self.token = token
    }
    
    public func get(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else { throw SBNetworkError.invalidURL }
        var request = URLRequest(url: url)
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { throw SBNetworkError.invalidResponse }
        return data
    }
    
    public func post(urlString: String, body: [String: Any]) async throws -> Data {
        guard let url = URL(string: urlString) else { throw SBNetworkError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            throw SBNetworkError.encodingFailed
        }
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { throw SBNetworkError.invalidResponse }
        return data
    }
    
    public func put(urlString: String, body: [String: Any]) async throws -> Data {
        guard let url = URL(string: urlString) else { throw SBNetworkError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            throw SBNetworkError.encodingFailed
        }
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { throw SBNetworkError.invalidResponse }
        return data
    }
}
