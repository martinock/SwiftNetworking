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

//NOTE: Use CodingKeys when we want to map keys into our standard (eg: snakecase from reponse to camelcase)
struct ArticleResponse: Codable {
    let totalResult: Int?
    var articles: [Article] = []
    let status: String?
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
            }
        }
    }
