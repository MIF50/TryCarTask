//
//  NetworkingClient.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit
import Alamofire
import Combine

extension AFDataResponse {
    
    var httpStatusCode: Int {
        return self.response?.statusCode ?? 0
    }
}

enum ServerError: Error {
    
    case server(String)
    case general(String)
    case parseError
    case httpCode(Int)
    
    var localizedDescription: String {
        switch self {
        case .general(let msg):
            return msg
        case .server(let msg):
            return msg
        case .httpCode(let statusCode):
            return "\(statusCode)"
        case .parseError:
            return "parseError"
        }
    }
}

class NetworkingClient {
    
    static let shared = NetworkingClient()
    var tokens: Set<AnyCancellable> = []

    private init() {}
        
    func didRequest<T: Decodable>(
        url: URL,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = PrefManager.shared.getHeaders(),
        expectedStatusCode: Int = 200,
        completion:@escaping (Result<T,Error>) -> Void) {
        
        print("***** LOG *****")
        print("Request: \(url)")
        print("Method: \(method.rawValue)")
        print("Parameters: \(parameters.debugDescription)")
        print("headers: \(headers.debugDescription)")
        print("***** END OF LOG *****")
        

        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<500)
            .responseJSON { response in
                guard let data = response.data else { return }
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print("Response json: \(result)")
                } catch {
                    print("Ressonse error: \(error.localizedDescription)")
                }
            }
            .publishDecodable(type: T.self)
            .value()
            .receive(on: DispatchQueue.main)
            .sink { resultCompletion in
                switch resultCompletion {
                case .failure(let error):
                completion(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { result in
                completion(.success(result))
            }
            .store(in: &tokens)
        }
}

