//
//  HttpClient.swift
//  Crud-Vapor-App
//
//  Created by gyda almohaimeed on 07/07/1444 AH.
//

import Foundation

enum HttpMethodes: String {
    case POST, GET, PUT, DELETE
}


enum MIMEType: String
{
   case JSON = "application/json"
}

enum HttpHeaders: String {
    case contebtType = "Content-Type"
}
enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL
}


class HttpClient {
    
    private init() { }
    
    static let shared = HttpClient()
    
    func fetch<T: Codable>(url: URL) async throws -> [T] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode([T].self, from: data) else{
            throw HttpError.errorDecodingData
        }
        
        return object
    }
    
    func sendData<T: Codable>(url: URL, object: T, httpMeyhod: String) async throws {
        var request = URLRequest(url: url)
        
        //tell the request what kind of data will locking for
        request.httpMethod = httpMeyhod
        request.addValue(MIMEType.JSON.rawValue,
                         forHTTPHeaderField: HttpHeaders.contebtType.rawValue)
        
        request.httpBody = try? JSONEncoder().encode(object)
        
        let(_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 300 else {
            throw HttpError.badResponse
        }
    }
    
    func delete(at id: UUID, url: URL) async throws {
        
        //new url request object
        var request = URLRequest(url: url)
        // set the methode to delete
        request.httpMethod = HttpMethodes.DELETE.rawValue
        // use the new url data and give it the request
        // let(_, response)the _ because we dont need to get data just a response
        let(_, response) = try await URLSession.shared.data(for: request)
        
        
        // get the response and cast it as an http url response then check if the status code is equal to 200
        // else if this doesnt work throw a bad response error
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
    
    
}
