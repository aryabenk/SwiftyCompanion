import UIKit
import Alamofire
import SwiftyJSON

class API42AccessRequest: NSObject {
    private let uId = "ec7e4a42b356bca04578b84c0358f2b11c53b8a530b33a51e42b05f83940c05b"
    private let secretId = "d605fe97c962bd1fcbb8a6b797b640e69bb035214c5482f63a79b61fe7391b42"
    var token = String()
    var student = GetUserInformation()
    
    func getToken() {
        let url = "https://api.intra.42.fr/oauth/token"
        let parameters = ["grant_type": "client_credentials",
                          "client_id": uId,
                          "client_secret": secretId]
        
        let verify = UserDefaults.standard.object(forKey: "token")
        if verify == nil {
            Alamofire.request(url, method: .post, parameters: parameters).validate().responseJSON {
                response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        self.token = json["access_token"].stringValue
                        UserDefaults.standard.set(json["access_token"].stringValue, forKey: "token")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        else {
            self.token = verify as! String
            print("SAME token:", self.token)
            checkToken()
        }
    }
    
    private func checkToken() {
        let url = URL(string: "https://api.intra.42.fr/oauth/token/info")
        let bearer = "Bearer " + self.token
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("The token will expire in: ", json["expires_in_seconds"], " sec.")
                }
            case .failure:
                print("Error: getting a new token.")
                UserDefaults.standard.removeObject(forKey: "token")
                self.getToken()
            }
        }
    }
    
    func checkStudent(studentName: String, completeonClosure: @escaping (AnyObject?) -> ()) {
        let userUrl = URL(string: "https://api.intra.42.fr/v2/users/" + studentName)
        let bearer = "Bearer " + self.token
        var request = URLRequest(url: userUrl!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
                case .success:
                    if let value = response.result.value {
                        completeonClosure(value as AnyObject?)
                    }
                case .failure:
                    print("no such student")
                    completeonClosure(nil as AnyObject?)
            }
        }
    }
    
    func getCoalition(studentId: Int, completeonClosure: @escaping (AnyObject?) -> ()) {
        let userUrl = URL(string: "https://api.intra.42.fr/v2/blocs/\(studentId)")
        let bearer = "Bearer " + self.token
        var request = URLRequest(url: userUrl!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    completeonClosure(value as AnyObject?)
                }
            case .failure:
                print("no coalition")
                completeonClosure(nil as AnyObject?)
            }
        }
    }
}
