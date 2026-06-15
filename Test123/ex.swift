//
//  ex.swift
//  Test123
//
//  Created by Apple on 15/06/26.
//



//MARK: APIManager.swift
//import Foundation
//
//enum HTTPMethod: String {
//    case GET
//    case POST
//    case PUT
//    case DELETE
//}
//
//enum APIError: Error, LocalizedError {
//    case invalidURL
//    case invalidResponse
//    case decodingError
//    case serverError(String)
//
//    var errorDescription: String? {
//        switch self {
//        case .invalidURL:
//            return "Invalid URL"
//        case .invalidResponse:
//            return "Invalid Response"
//        case .decodingError:
//            return "Failed to decode response"
//        case .serverError(let message):
//            return message
//        }
//    }
//}
//
//final class APIManager {
//
//    static let shared = APIManager()
//
//    private init() {}
//
//    func request<T: Decodable, U: Encodable>(
//        urlString: String,
//        method: HTTPMethod,
//        body: U? = nil,
//        headers: [String: String] = [:]
//    ) async throws -> T {
//
//        guard let url = URL(string: urlString) else {
//            throw APIError.invalidURL
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        headers.forEach {
//            request.setValue($0.value, forHTTPHeaderField: $0.key)
//        }
//
//        if let body = body {
//            request.httpBody = try JSONEncoder().encode(body)
//        }
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw APIError.invalidResponse
//        }
//
//        guard 200...299 ~= httpResponse.statusCode else {
//            throw APIError.serverError("Status Code: \(httpResponse.statusCode)")
//        }
//
//        do {
//            return try JSONDecoder().decode(T.self, from: data)
//        } catch {
//            throw APIError.decodingError
//        }
//    }
//}





//MARK: EmptyBody.swift
//import Foundation
//
//struct EmptyBody: Encodable {}



//MARK: Models
//import Foundation
//
//struct User: Codable, Identifiable {
//    let id: Int?
//    let name: String
//    let email: String
//}
//
//struct UserResponse: Codable {
//    let id: Int?
//    let name: String
//    let email: String
//}


//MARK: ViewModel.swift
//import Foundation
//
//@MainActor
//class UserViewModel: ObservableObject {
//
//    @Published var users: [User] = []
//    @Published var message = ""
//
//    let baseURL = "https://jsonplaceholder.typicode.com/users"
//
//    // MARK: GET
//
//    func getUsers() async {
//        do {
//            let result: [User] = try await APIManager.shared.request(
//                urlString: baseURL,
//                method: .GET,
//                body: Optional<EmptyBody>.none
//            )
//
//            users = result
//        } catch {
//            message = error.localizedDescription
//        }
//    }
//
//    // MARK: POST
//
//    func createUser() async {
//
//        let user = User(
//            id: nil,
//            name: "Subramaniyan",
//            email: "subramaniyan@gmail.com"
//        )
//
//        do {
//            let response: UserResponse = try await APIManager.shared.request(
//                urlString: baseURL,
//                method: .POST,
//                body: user
//            )
//
//            message = "Created User: \(response.name)"
//        } catch {
//            message = error.localizedDescription
//        }
//    }
//
//    // MARK: PUT
//
//    func updateUser(id: Int) async {
//
//        let user = User(
//            id: id,
//            name: "Updated Name",
//            email: "updated@gmail.com"
//        )
//
//        do {
//            let response: UserResponse = try await APIManager.shared.request(
//                urlString: "\(baseURL)/\(id)",
//                method: .PUT,
//                body: user
//            )
//
//            message = "Updated User: \(response.name)"
//        } catch {
//            message = error.localizedDescription
//        }
//    }
//
//    // MARK: DELETE
//
//    func deleteUser(id: Int) async {
//
//        do {
//            let _: UserResponse = try await APIManager.shared.request(
//                urlString: "\(baseURL)/\(id)",
//                method: .DELETE,
//                body: Optional<EmptyBody>.none
//            )
//
//            message = "User Deleted"
//        } catch {
//            message = error.localizedDescription
//        }
//    }
//}




//MARK: ContentView.swift

//import SwiftUI
//
//struct ContentView: View {
//
//    @StateObject private var viewModel = UserViewModel()
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//
//                Button("GET Users") {
//                    Task {
//                        await viewModel.getUsers()
//                    }
//                }
//
//                Button("POST User") {
//                    Task {
//                        await viewModel.createUser()
//                    }
//                }
//
//                Button("PUT User") {
//                    Task {
//                        await viewModel.updateUser(id: 1)
//                    }
//                }
//
//                Button("DELETE User") {
//                    Task {
//                        await viewModel.deleteUser(id: 1)
//                    }
//                }
//
//                Text(viewModel.message)
//                    .foregroundColor(.blue)
//
//                List(viewModel.users) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//
//                        Text(user.email)
//                            .font(.caption)
//                    }
//                }
//            }
//            .navigationTitle("API Manager")
//        }
//    }
//}
