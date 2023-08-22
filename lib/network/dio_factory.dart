import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

/// A factory class for creating a singleton [Dio] instance with cache interceptor.
class DioFactory {
  DioFactory._(); // Private constructor to prevent direct instantiation.

  static final DioFactory _instance = DioFactory._();

  /// Get the singleton instance of [DioFactory].
  static DioFactory get instance => _instance;

  // Global cache options for DioCacheInterceptor.
  final options = CacheOptions(
    // A default store is required for the interceptor.
    store: MemCacheStore(),

    // All subsequent fields are optional.

    // Default cache policy.
    policy: CachePolicy.request,

    // Returns a cached response on error for statuses 401 & 403.
    // Also allows returning a cached response on network errors (e.g., offline usage).
    hitCacheOnErrorExcept: [401, 403],

    // Overrides any HTTP directive to delete the entry after this duration.
    // Useful only when the origin server has no cache config or custom behavior is desired.
    maxStale: const Duration(days: 7),

    // Default. Allows 3 cache sets and eases cleanup.
    priority: CachePriority.normal,

    // Default. Body and headers encryption with your own algorithm.
    cipher: null,

    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,

    // Default. Allows caching POST requests. Overriding [keyBuilder] is strongly recommended.
    allowPostMethod: false,
  );

  /// Creates and returns a [Dio] instance configured with cache interceptor.
  Dio createDioInstance({Map<String, dynamic>? headers}) {
    Dio dio = Dio();
    dio.interceptors.add(DioCacheInterceptor(options: options));
    return dio;
  }
}
