# Crud-Vapor-App
iOS CRUD App using [Vapor API ](https://github.com/gyda13/First-Vapor-API) 



## Technologies
- SwiftUi


## CREAT
- Http Client
```swift
func sendData<T: Codable>(url: URL, object: T, httpMeyhod: String) async throws {
        var request = URLRequest(url: url)
        
        //tell the request what kind of data we are locking for
        request.httpMethod = httpMeyhod
        request.addValue(MIMEType.JSON.rawValue,
                         forHTTPHeaderField: HttpHeaders.contebtType.rawValue)
        
        request.httpBody = try? JSONEncoder().encode(object)
        
        let(_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 300 else {
            throw HttpError.badResponse
        }
    }
   ```
 - View Model
 
   ```swift
  let product = Product(id: nil, name: productName, actual_price: actualPrice, profit_price: profitPrice, work_price: workPrice,  quantity: Quintity)
        try await HttpClient.shared.sendData(url: url, object: product,
                                             httpMeyhod: HttpMethodes.POST.rawValue)
      
   ```
    

## READ
- Http Client
```swift
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
   ```
 - View Model
   ```swift

        let productResponse: [Product] = try await HttpClient.shared.fetch(url: url)
        DispatchQueue.main.async {
            self.products = productResponse
        }
   ```
   
   ## UPDATE
   
   - Http Client
- fetch func
 - View Model
   ```swift
 let productToUpdate = Product(id: productID, name: productName, actual_price: actualPrice, profit_price: profitPrice, work_price: workPrice,  quantity: Quintity)
        try await HttpClient.shared.sendData(url: url, object: productToUpdate,
                                             httpMeyhod: HttpMethodes.PUT.rawValue)
   ```
   
   ## DELETE
   
   - Http Client
   delete func will take the product id
```swift
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
    
    
   ```
 - View Model
   ```swift
  In the ViewModel, iterate over the list of product id and pass the one that matches to delete func.
 // delete the product from the database
        offesets.forEach { i in
            guard let productId = products[i].id else {
                return
            }
            guard let url = URL(string: Constants.baseURL + Endpoints.products
             + "/\(productId)") else {
                return
            }
            Task {
                do {
                    try await HttpClient.shared.delete(at: productId, url: url)
                } catch {
                    print("Error: \(error)")
                }
            }
        } 
        // delet the product from the Producr array in the view
        products.remove(atOffsets: offesets)
   }
   ```
   





