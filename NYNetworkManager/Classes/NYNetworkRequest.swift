import Alamofire
import NYSwiftExtension

public typealias CompletionHandler = (DataResponse<Any>) -> Void

public class NYNetworkRequest<APIType: NYNetworkProtocol> {
    
    public func request(apiType: APIType, completionHandler: @escaping CompletionHandler) {
        
        var urlStr: String = NYBaseURL + apiType.path
        var parameters: [String: Any]? = nil
        
        parameters = apiType.parameters
        
        if let _parameters = parameters {
            for (key, value) in _parameters {
                if let _value = value as? String {
                    if _value == "" {
                        parameters?.removeValue(forKey: key)
                    }
                }
            }
        }
        
        switch apiType.encoding.destination {
        case .httpBody:
            
            let url: URL = URL.init(string: urlStr)!
            var httpBodyRequest: URLRequest = URLRequest.init(url: url)


            httpBodyRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            httpBodyRequest.httpMethod = apiType.httpMethod.rawValue
            httpBodyRequest.httpBody = parameters?.jsonString()?.data(using: .utf8)
            let dataRequest = Alamofire.request(httpBodyRequest)
            dataRequest.responseJSON { data in
                completionHandler(data)
            }
            
        case .queryString:
            
            let headers: [String: String] = ["Content-Type": "application/json;charset=UTF-8"]
            let dataRequest: DataRequest = Alamofire.request(urlStr, method: apiType.httpMethod, parameters: parameters, encoding: apiType.encoding, headers: headers)
            dataRequest.responseJSON { data in
                completionHandler(data)
            }
            
        default: break
        }
        
    }
    
}
