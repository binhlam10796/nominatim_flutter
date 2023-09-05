/// [DioCacheConfiguration] provides a centralized configuration for Dio's cache interceptors.
///
/// This configuration serves as the primary point to control the behavior of caching within
/// the Dio HTTP client across the application. The settings defined here can be dynamically
/// altered based on the app's requirements.
class DioCacheConfiguration {
  /// Determines if the cache interceptor should be used.
  static bool useCacheInterceptor = true;

  /// Specifies the duration after which the cached response is considered stale.
  /// After this duration, the cache will no longer be used and a fresh network request will be made.
  static Duration maxStale = const Duration(days: 7);
}
