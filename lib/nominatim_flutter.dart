import 'package:nominatim_flutter/config/dio_cache_configuration.dart';

import 'model/request/request.dart';
import 'model/response/reverse_response.dart';
import 'service/nominatim_service.dart';

/// [NominatimFlutter] provides a utility for interacting with the Nominatim service.
/// It supports operations such as reverse geocoding and searching based on various criteria.
///
/// This class adopts the Singleton design pattern to ensure a single instance throughout the application.
class NominatimFlutter {
  // Singleton instance of [NominatimFlutter].
  static final _instance = NominatimFlutter._();

  /// Provides access to the singleton instance of [NominatimFlutter].
  static NominatimFlutter get instance => _instance;

  // Private constructor for Singleton implementation.
  NominatimFlutter._();

  // Instance of the service responsible for interacting with the Nominatim API.
  final _nominatimService = NominatimServiceImpl();

  /// Configures caching behavior for the Dio client used within the Nominatim service.
  ///
  /// [useCacheInterceptor] - Determines if caching should be applied to Dio requests.
  /// [maxStale] - Specifies the maximum duration for which a cached response is considered valid.
  void configureDioCache({
    bool useCacheInterceptor = true,
    Duration maxStale = const Duration(days: 7),
  }) {
    DioCacheConfiguration.useCacheInterceptor = useCacheInterceptor;
    DioCacheConfiguration.maxStale = maxStale;
  }

  /// Performs a reverse geocoding operation based on the given latitude and longitude.
  ///
  /// [reverseRequest] - A [ReverseRequest] object containing details like latitude and longitude for the lookup.
  Future<NominatimResponse> reverse({
    required ReverseRequest reverseRequest,
    String? language,
  }) async {
    return await _nominatimService.reverse(
      reverseRequest: reverseRequest,
      language: language,
    );
  }

  /// Conducts a search operation to retrieve places matching the provided search criteria.
  ///
  /// [searchRequest] - A [SearchRequest] object encapsulating search parameters and filters.
  Future<List<NominatimResponse>> search({
    required SearchRequest searchRequest,
    String? language,
  }) async {
    return await _nominatimService.search(
      searchRequest: searchRequest,
      language: language,
    );
  }
}
