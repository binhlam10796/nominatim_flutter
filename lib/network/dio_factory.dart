import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:nominatim_flutter/config/dio_cache_configuration.dart';
import 'package:nominatim_flutter/config/nominatim_configuration.dart';
import 'package:nominatim_flutter/network/curl_interceptor.dart';

/// A factory class responsible for creating and configuring instances of [Dio]
/// with caching capabilities provided by [DioCacheInterceptor].
class DioFactory {
  // Singleton pattern to ensure a single instance of DioFactory
  DioFactory._();

  static final DioFactory _instance = DioFactory._();

  /// Get the singleton instance of [DioFactory].
  static DioFactory get instance => _instance;

  /// Default cache options for DioCacheInterceptor.
  final CacheOptions _defaultCacheOptions = _createDefaultCacheOptions();

  /// Constructs the default cache options for [DioCacheInterceptor].
  ///
  /// This consolidates and centralizes cache-related configurations to
  /// ensure consistent behavior across different parts of the application.
  static CacheOptions _createDefaultCacheOptions() {
    return CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale:
          NominatimConfiguration.maxStale ?? DioCacheConfiguration.maxStale,
      priority: CachePriority.normal,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );
  }

  /// Creates and returns a [Dio] instance that's pre-configured with caching capabilities.
  ///
  /// Uses the [DioCacheInterceptor] to provide caching functionality,
  /// relying on the cache configurations provided in [_defaultCacheOptions].
  Dio createDioInstance() {
    Dio dio = Dio();

    if (NominatimConfiguration.enableCurlLog ?? false) {
      dio.interceptors.add(
        CurlInterceptor(
          printOnSuccess: NominatimConfiguration.printOnSuccess,
          convertFormData: NominatimConfiguration.convertFormData,
        ),
      );
    }

    // Integrate cache interceptor if caching is enabled in configurations
    if (NominatimConfiguration.useCacheInterceptor ??
        DioCacheConfiguration.useCacheInterceptor) {
      dio.interceptors.add(DioCacheInterceptor(options: _defaultCacheOptions));
    }

    return dio;
  }
}
