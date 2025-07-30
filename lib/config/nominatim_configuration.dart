/// [NominatimConfiguration] provides a centralized configuration for managing
/// settings related to the Nominatim API and Dio's cache interceptors.
///
/// This class serves as the primary point to control the behavior of caching
/// and other configurations for the Nominatim API integration within the application.
/// The settings defined here can be dynamically adjusted based on the app's requirements.
class NominatimConfiguration {
  /// Indicates whether the cache interceptor should be enabled for HTTP requests.
  static bool? useCacheInterceptor = true;

  /// Defines the maximum duration after which a cached response is considered stale.
  /// Once this duration is exceeded, the cache will no longer be used, and a fresh
  /// network request will be triggered.
  static Duration? maxStale = const Duration(days: 7);

  /// Specifies the User-Agent string to be used for HTTP requests to the Nominatim API.
  static String? userAgent = 'NominatimFlutter/0.0.8';

  /// Specifies the base URL for the Nominatim API.
  /// Defaults to the official OpenStreetMap Nominatim instance.
  static String? baseUrl = 'https://nominatim.openstreetmap.org';

  /// Indicates whether cURL logs should be displayed for HTTP requests.
  static bool? enableCurlLog = false;

  /// Whether to log cURL commands for successful HTTP responses.
  static bool? printOnSuccess = false;

  /// Whether to convert FormData into a JSON-like structure for logging purposes.
  static bool convertFormData = false;
}
