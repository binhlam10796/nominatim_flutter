part of 'api_provider.dart'; // Assuming this file is used as a part of api_provider.dart.

/// Enumeration of HTTP methods for API requests.
enum HTTPMethod { get, post, delete, put, patch }

/// Extension to convert [HTTPMethod] enum values to their string representations.
extension HTTPMethodString on HTTPMethod {
  String get string {
    switch (this) {
      case HTTPMethod.get:
        return "get";
      case HTTPMethod.post:
        return "post";
      case HTTPMethod.delete:
        return "delete";
      case HTTPMethod.patch:
        return "patch";
      case HTTPMethod.put:
        return "put";
    }
  }
}

/// An abstract class representing an API request with various properties.
abstract class APIRequestRepresentable {
  /// URLs for the API request.
  String get urls;

  /// Endpoints for the API request.
  String get endpoints;

  /// Paths for the API request.
  String get paths;

  /// HTTP method for the API request.
  HTTPMethod get methods;

  /// Headers for the API request.
  Map<String, String>? get headers;

  /// Query parameters for the API request.
  Map<String, String>? get queries;

  /// Request bodies for the API request.
  dynamic get bodies;

  /// Perform the API request and return the response.
  Future request();
}
