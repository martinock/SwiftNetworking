import Alamofire
import UIKit

struct ArticleSource: Codable {
    let id: String?
    let name: String?
}

struct Article: Codable {
    let source: ArticleSource?
    let author: String?
    let title: String?
    let description: String?
}


struct ArticleResponse: Codable {
    let totalResults: Int?
    var articles: [Article] = []
    let status: String?
    
    //NOTE: Use CodingKeys when we want to map keys into our standard (eg: snakecase from reponse to camelcase)
//    enum CodingKeys: String, CodingKey {
//        case total_results = "totalResults"
//        case articles
//        case status
//    }
}

Alamofire
    .request("https://newsapi.org/v2/everything?q=bitcoin&from=2018-10-14&sortBy=publishedAt&apiKey=72fbf5e64b3448d2a8ebbb71fc9dba7f")
    .responseJSON{(response) in
        if let data = response.data {
            print("Response from server")
            
            //NOTE: A way to map data to our struct
            let jsonDecoder = JSONDecoder()
            if let mappedResponse = try? jsonDecoder.decode(ArticleResponse.self, from: data) {
                print(mappedResponse.articles)
                
                //NOTE: Need to check value before print, especially when the value is nil. Will remove "Optional()" when printing
//                if let total = mappedResponse.totalResults {
//                    print(total)
//                }
                
                //NOTE: Give default value to optional response
//                let total = mappedResponse.totalResults ?? 0
//                print(total)
            }
        }
    }
