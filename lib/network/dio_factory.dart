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

  /// Cached Dio instance
  Dio? _dioInstance;

  /// Configuration snapshot to detect changes
  Map<String, dynamic>? _lastConfig;

  /// Default cache options for DioCacheInterceptor.
  CacheOptions get _defaultCacheOptions => _createDefaultCacheOptions();

  /// Constructs the default cache options for [DioCacheInterceptor].
  ///
  /// This consolidates and centralizes cache-related configurations to
  /// ensure consistent behavior across different parts of the application.
  CacheOptions _createDefaultCacheOptions() {
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

  /// Creates a snapshot of the current configuration for comparison
  Map<String, dynamic> _getCurrentConfig() {
    return {
      'useCacheInterceptor': NominatimConfiguration.useCacheInterceptor ?? DioCacheConfiguration.useCacheInterceptor,
      'maxStale': NominatimConfiguration.maxStale ?? DioCacheConfiguration.maxStale,
      'enableCurlLog': NominatimConfiguration.enableCurlLog ?? false,
      'printOnSuccess': NominatimConfiguration.printOnSuccess ?? false,
      'convertFormData': NominatimConfiguration.convertFormData,
      'userAgent': NominatimConfiguration.userAgent,
      'baseUrl': NominatimConfiguration.baseUrl,
    };
  }

  /// Checks if configuration has changed since last Dio instance creation
  bool _hasConfigChanged() {
    final currentConfig = _getCurrentConfig();
    if (_lastConfig == null) {
      _lastConfig = currentConfig;
      return true;
    }
    
    final hasChanged = !_mapsEqual(_lastConfig!, currentConfig);
    if (hasChanged) {
      _lastConfig = currentConfig;
    }
    return hasChanged;
  }

  /// Helper method to compare maps
  bool _mapsEqual(Map<String, dynamic> map1, Map<String, dynamic> map2) {
    if (map1.length != map2.length) return false;
    for (final key in map1.keys) {
      if (map1[key] != map2[key]) return false;
    }
    return true;
  }

  /// Creates and returns a [Dio] instance that's pre-configured with caching capabilities.
  ///
  /// Uses the [DioCacheInterceptor] to provide caching functionality,
  /// relying on the cache configurations provided in [_defaultCacheOptions].
  /// 
  /// The instance is cached and reused unless the configuration has changed.
  Dio createDioInstance() {
    // Check if we need to recreate the Dio instance due to configuration changes
    if (_dioInstance == null || _hasConfigChanged()) {
      _dioInstance = _createNewDioInstance();
    }
    
    return _dioInstance!;
  }

  /// Creates a new Dio instance with current configuration
  Dio _createNewDioInstance() {
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
