import Foundation
import FoundationNetworking

class CatDataService{
    
    static let instance:CatDataService = CatDataService()

    func getBreeds(onCompletion:@escaping CallbackBlock<Cat> /* onError:ErrorBlock? */){

        let url = URL(string: "https://api.thecatapi.com/v1/breeds")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) {data , response, error in
            guard let data = data else {return}
            do {
                let decodeData : [Cat] = try JSONDecoder().decode([Cat].self, from:data)

                onCompletion(decodeData)
                
            } catch  {
                print("Fail")

            }

        }
        task.resume()
    }
        
}