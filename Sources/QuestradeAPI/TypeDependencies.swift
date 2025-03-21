
#if canImport(Foundation)

import Foundation

public typealias URL = Foundation.URL
public typealias URLComponents = Foundation.URLComponents
public typealias URLSession = Foundation.URLSession
public typealias URLRequest = Foundation.URLRequest
public typealias URLQueryItem = Foundation.URLQueryItem
public typealias URLSessionWebSocketTask = Foundation.URLSessionWebSocketTask

public typealias NSCoder = Foundation.NSCoder
public typealias Data = Foundation.Data
public typealias JSONSerialization = Foundation.JSONSerialization
public typealias JSONEncoder = Foundation.JSONEncoder
public typealias JSONDecoder = Foundation.JSONDecoder

public typealias Date = Foundation.Date
public typealias DateInterval = Foundation.DateInterval
public typealias DateFormatter = Foundation.DateFormatter
public typealias Calendar = Foundation.Calendar

public typealias LocalizedError = Foundation.LocalizedError
public typealias UUID = Foundation.UUID

#else

public typealias URL = Never
public typealias URLComponents = Never
public typealias URLSession = Never
public typealias URLRequest = Never
public typealias URLQueryItem = Never
public typealias URLSessionWebSocketTask = Never

public typealias NSCoder = Never
public typealias Data = Never
public typealias JSONSerialization = Never
public typealias JSONEncoder = Never
public typealias JSONDecoder = Never

public typealias Date = Never
public typealias DateInterval = Never
public typealias DateFormatter = Never
public typealias Calendar = Never

public typealias LocalizedError = Never
public typealias UUID = Never

#endif
