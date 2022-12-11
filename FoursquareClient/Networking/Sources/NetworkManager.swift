//
//  NetworkManager.swift
//  FoursquareClient
//
//  Created by Ilke Uygun on 11/28/22.
//

import Alamofire
import Foundation

public typealias NetworkCompletionHandler = (AFDataResponse<Data?>) -> Void

public final class NetworkManager {
  
  private let session: Session
  
  public init(session: Session = Session(interceptor: NetworkInterceptor())) {
    self.session = session
  }
  
  public func fetch<T: Decodable>(
    _ request: Endpoint,
    type: T.Type,
    result: @escaping ((Result<T, APIError>) -> Void)
  ) {
    do {
      let url = try request.asURL()
      
      let completionHandler: NetworkCompletionHandler = { (response) in
        DispatchQueue.main.async {
          switch(response.result) {
          case .success(let data):
            guard let data = data else {
              // Successfully received response but there is no data
              result(.failure(.noData))
              return
            }
            do {
              let responseObject = try JSONDecoder().decode(T.self, from: data)
              // Successfully received response
              result(.success(responseObject))
            }
            catch {
              // Error when decoding response
              result(.failure(.decoding))
            }
          case let .failure(error):
            // Error from endpoint
            result(.failure(APIError(description: error.localizedDescription)))
            break
          }
        }
      }
      session.request(url).validate().response(completionHandler: completionHandler)
    }
    catch {
      // URL error
      result(.failure(.noCastUrl))
    }
  }
}
