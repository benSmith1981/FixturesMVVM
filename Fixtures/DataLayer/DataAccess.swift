import Foundation
import Alamofire


struct Response: Codable {
    let matches: [Match]
    let competition: Competition

}

struct Competition: Codable {
    let name: String
}

struct Match: Codable {
    let homeTeam: Name
    let awayTeam: Name
    let utcDate: String
    let status: String?
    let score: Score

}
struct Name: Codable {
    let name: String
}

struct Score: Codable {
    let fullTime: FullTime
}

struct FullTime: Codable {
    var homeTeam: Int?
    var awayTeam: Int?
}

enum UrlConnectionError: Error {
    case invalid(String)
    case connectionError(String)
    case dataError(String)
    case decodingError(String)
}

class DataAccess {

    var baseUrl: String
    
    init(baseURL: String = "http://api.football-data.org/v2/competitions/ELC/matches") {
        self.baseUrl = baseURL
    }

    func fetchMatches(completionHandler: @escaping ((Response?, UrlConnectionError?) -> Void)) {
        let headers: HTTPHeaders = [
            "X-Auth-Token": "3ee966f08dbd47fb8bf5c3d378d541a5"
        ]

        Alamofire.request(baseUrl, headers: headers).responseJSON { response in


            if let jsonData = response.data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Response.self, from: jsonData)
                    return completionHandler(response, nil)
                } catch {
                    print("Unexpected error: JSON parsing error")
                    return completionHandler(nil, .invalid(error.localizedDescription))
                }
            } else {
                return completionHandler(nil, .dataError("Data response error"))
            }
        }
    }
    
    func fetchFromStaticJSON(onCompletion: @escaping (Response?,UrlConnectionError?) -> Void) {
        if let path = Bundle.main.path(forResource: "fixtures", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>{//,

                    let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: [])
                    
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(Response.self,
                                                                from: jsonData )
                        onCompletion(response, nil)
                        
                    } catch {
                        onCompletion(nil, .invalid(error.localizedDescription))
                    }
                }
            } catch {
                // handle error
                onCompletion(nil, .dataError("Data response error"))
                
            }
        }
        
    }
}
