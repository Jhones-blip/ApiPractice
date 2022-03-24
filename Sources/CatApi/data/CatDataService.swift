import Foundation
import FoundationNetworking

class CatDataService{
    
    static let instance:CatDataService = CatDataService()
    let catApiToken = "b31e3cf7-0b06-49c0-bb3b-cc1eaf8561c0"

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

    func addVotes(data:String) {

        let semaphore = DispatchSemaphore (value: 0)
        let postData = data.data(using: .utf8)
        let url = URL(string: "https://api.thecatapi.com/v1/votes")!
        var request = URLRequest(url: url)
        request.addValue(catApiToken, forHTTPHeaderField: "x-api-key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request){data , response, error in 
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            // print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    } 


    func getVotes(onCompletion:@escaping CallbackBlock<Vote>){

        let url = URL(string: "https://api.thecatapi.com/v1/votes")!
        var request = URLRequest(url: url)
        request.addValue(catApiToken, forHTTPHeaderField: "x-api-key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
                
        let task = URLSession.shared.dataTask(with: request){data , response, error in 
            guard let data = data else { return }
            do {
                let decodeData : [Vote] = try JSONDecoder().decode([Vote].self, from: data)

                // DispatchQueue.main.async {
                    onCompletion(decodeData)
                    // self.catsData=decodeData
                // }
            } catch {
                print("******* Faild Vote *********")
                print(error)
                // onError?(error)
            }
        }
        task.resume()

    }
        
}