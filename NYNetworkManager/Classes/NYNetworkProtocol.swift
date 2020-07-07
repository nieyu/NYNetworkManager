import Alamofire

public typealias NYHttpMethod = HTTPMethod
public typealias NYURLEncoding = URLEncoding

public var NYBaseURL: String = "https://www.baidu.com"

public protocol NYNetworkProtocol {
    var path: String { get }
    var parameters: [String: Any]? { get }
    var httpMethod: NYHttpMethod { get }
    var encoding: NYURLEncoding { get }
}
