import Foundation
import Alamofire


struct Response: Codable {
    let matches: [Match]
}
struct Match: Codable {
    let homeTeam: Name
    let awayTeam: Name
    let utcDate: String?
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

class DataAccess {

    var baseUrl: String
    
    init(baseURL: String = "http://api.football-data.org/v2/competitions/ELC/matches") {
        self.baseUrl = baseURL
    }

    func fetchMatches(completionHandler: @escaping (([Match]?) -> Void)) {
        let headers: HTTPHeaders = [
            "X-Auth-Token": "3ee966f08dbd47fb8bf5c3d378d541a5"
        ]

        Alamofire.request(baseUrl, headers: headers).responseJSON { response in


            if let jsonData = response.data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Response.self, from: jsonData)
                    return completionHandler(response.matches)
                } catch {
                    print("Unexpected error: JSON parsing error")
                    return completionHandler([])
                }
            } else {
                return completionHandler([])
            }
        }
    }
    
    func fetchFromStaticJSON(onCompletion: @escaping ([Match]?) -> Void) {
        if let path = Bundle.main.path(forResource: "fixtures", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>{//,
                   // let connections = jsonResult["matches"] as? [Any] {
                    // do stuff
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: [])
                    
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(Response.self,
                                                                from: jsonData )
                        onCompletion(response.matches)
                        
                    } catch {
                        onCompletion([])
                    }
                }
            } catch {
                // handle error
                onCompletion([])
                
            }
        }
        
    }
}
