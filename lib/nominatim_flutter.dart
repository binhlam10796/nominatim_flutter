import 'package:nominatim_flutter/config/dio_cache_configuration.dart';
import 'package:nominatim_flutter/config/nominatim_configuration.dart';

import 'model/request/request.dart';
import 'model/response/response.dart';
import 'service/nominatim_service.dart';

/// [NominatimFlutter] is a utility class designed for interacting with the Nominatim service,
/// providing functionalities such as reverse geocoding and place searching based on various criteria.
///
/// This class follows the Singleton design pattern to ensure a single instance is used throughout the application,
/// promoting efficient resource utilization and consistent configuration.
///
/// The class includes methods to configure caching behavior for the Dio client, perform reverse geocoding,
/// conduct search operations, and check the status of the Nominatim service.
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
  @Deprecated(
      'This method is deprecated and will be removed in a future release.\n'
      'Please migrate to the `configureNominatim` method, which provides improved functionality and better maintainability.\n'
      'Using this method may result in unexpected behavior or lack of support for new features.\n'
      'It is strongly recommended to update your codebase to use the new method.')
  void configureDioCache({
    bool useCacheInterceptor = true,
    Duration maxStale = const Duration(days: 7),
  }) {
    DioCacheConfiguration.useCacheInterceptor = useCacheInterceptor;
    DioCacheConfiguration.maxStale = maxStale;
  }

  void configureNominatim({
    bool useCacheInterceptor = true,
    Duration maxStale = const Duration(days: 7),
    String? userAgent,
    bool enableCurlLog = false,
    bool printOnSuccess = false,
    bool convertFormData = false,
  }) {
    NominatimConfiguration.useCacheInterceptor = useCacheInterceptor;
    NominatimConfiguration.maxStale = maxStale;
    NominatimConfiguration.userAgent = userAgent;
    NominatimConfiguration.enableCurlLog = enableCurlLog;
    NominatimConfiguration.printOnSuccess = printOnSuccess;
    NominatimConfiguration.convertFormData = convertFormData;
  }

  /// Performs a reverse geocoding operation based on the given latitude and longitude.
  ///
  /// [reverseRequest] - A [ReverseRequest] object containing details like latitude and longitude for the lookup.
  /// [language] - Optional parameter to specify the language for the response.
  ///
  /// Returns a [Future] that resolves to a [NominatimResponse] containing the reverse geocoding results.
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
  /// [language] - Optional parameter to specify the language for the response.
  ///
  /// Returns a [Future] that resolves to a list of [NominatimResponse] objects containing the search results.
  Future<List<NominatimResponse>> search({
    required SearchRequest searchRequest,
    String? language,
  }) async {
    return await _nominatimService.search(
      searchRequest: searchRequest,
      language: language,
    );
  }

  /// Retrieves the status of the Nominatim service.
  ///
  /// Returns a [Future] that resolves to a [StatusResponse] containing the status information.
  Future<StatusResponse> status() async {
    return await _nominatimService.status();
  }

  /// Performs a lookup operation to retrieve places based on the provided lookup criteria.
  ///
  /// [lookupRequest] - A [LookupRequest] object containing details like place IDs for the lookup.
  /// [language] - Optional parameter to specify the language for the response.
  ///
  /// Returns a [Future] that resolves to a list of [NominatimResponse] objects containing the lookup results.
  Future<List<NominatimResponse>> lookup({
    required LookupRequest lookupRequest,
    String? language,
  }) async {
    return await _nominatimService.lookup(
      lookupRequest: lookupRequest,
      language: language,
    );
  }
}
