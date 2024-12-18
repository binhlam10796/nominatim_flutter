import '../model/isolate_helper_mixin.dart';
import '../model/request/request.dart';
import '../model/response/response.dart';
import 'nominatim_service_client.dart';

/// Abstract class defining the methods for interacting with the Nominatim service.
abstract class NominatimService {
  /// Searches for locations based on the given [searchRequest].
  ///
  /// The [searchRequest] parameter is required and contains the search criteria.
  /// The optional [language] parameter specifies the language for the search results.
  ///
  /// Returns a [Future] that completes with a list of [NominatimResponse] objects.
  Future<List<NominatimResponse>> search({
    required SearchRequest searchRequest,
    String? language,
  });

  /// Performs a reverse geocoding request based on the given [reverseRequest].
  ///
  /// The [reverseRequest] parameter is required and contains the reverse geocoding criteria.
  /// The optional [language] parameter specifies the language for the search results.
  ///
  /// Returns a [Future] that completes with a [NominatimResponse] object.
  Future<NominatimResponse> reverse({
    required ReverseRequest reverseRequest,
    String? language,
  });

  /// Retrieves the status of the Nominatim service.
  ///
  /// Returns a [Future] that completes with a [StatusResponse] object.
  Future<StatusResponse> status();

  /// Performs a lookup request to the Nominatim service.
  ///
  /// This function sends a lookup request with the specified parameters to the
  /// Nominatim service and returns a list of [NominatimResponse] objects.
  ///
  /// The [lookupRequest] parameter is required and contains the details of the
  /// lookup request.
  ///
  /// The [language] parameter is optional and specifies the language in which
  /// the results should be returned.
  ///
  /// Returns a [Future] that completes with a list of [NominatimResponse] objects.
  ///
  /// Example usage:
  /// ```dart
  /// final responses = await nominatimService.lookup(
  ///   lookupRequest: LookupRequest(...),
  ///   language: 'en',
  /// );
  /// ```
  Future<List<NominatimResponse>> lookup({
    required LookupRequest lookupRequest,
    String? language,
  });
}

/// Implementation of the [NominatimService] interface.
class NominatimServiceImpl with IsolateHelperMixin implements NominatimService {
  /// Performs a reverse geocoding request based on the given [reverseRequest].
  ///
  /// The [reverseRequest] parameter is required and contains the reverse geocoding criteria.
  /// The optional [language] parameter specifies the language for the search results.
  ///
  /// Returns a [Future] that completes with a [NominatimResponse] object.
  @override
  Future<NominatimResponse> reverse({
    required ReverseRequest reverseRequest,
    String? language,
  }) async {
    return await loadWithIsolate(() async {
      var response = await NominatimServiceClient(
        type: NominatimServiceType.reverse,
        reverseRequest: reverseRequest,
        language: language,
      ).request();
      return NominatimResponse.fromJson(response);
    });
  }

  /// Searches for locations based on the given [searchRequest].
  ///
  /// The [searchRequest] parameter is required and contains the search criteria.
  /// The optional [language] parameter specifies the language for the search results.
  ///
  /// Returns a [Future] that completes with a list of [NominatimResponse] objects.
  @override
  Future<List<NominatimResponse>> search({
    required SearchRequest searchRequest,
    String? language,
  }) async {
    return await loadWithIsolate(() async {
      var response = await NominatimServiceClient(
        type: NominatimServiceType.search,
        searchRequest: searchRequest,
        language: language,
      ).request();

      // Convert response to a list of NominatimResponse objects
      return (response as List<dynamic>)
          .map<NominatimResponse>(
              (i) => NominatimResponse.fromJson(i as Map<String, dynamic>))
          .toList();
    });
  }

  /// Retrieves the status of the Nominatim service.
  ///
  /// Returns a [Future] that completes with a [StatusResponse] object.
  @override
  Future<StatusResponse> status() async {
    return await loadWithIsolate(() async {
      var response = await NominatimServiceClient(
        type: NominatimServiceType.status,
      ).request();

      // Convert response to a StatusResponse object
      return StatusResponse.fromJson(response as Map<String, dynamic>);
    });
  }

  /// Performs a lookup request to the Nominatim service.
  ///
  /// The [lookupRequest] parameter is required and contains the details of the
  /// lookup request.
  /// The optional [language] parameter specifies the language for the search results.
  ///
  /// Returns a [Future] that completes with a list of [NominatimResponse] objects.
  @override
  Future<List<NominatimResponse>> lookup({
    required LookupRequest lookupRequest,
    String? language,
  }) async {
    return await loadWithIsolate(() async {
      var response = await NominatimServiceClient(
        type: NominatimServiceType.lookup,
        lookupRequest: lookupRequest,
        language: language,
      ).request();

      // Convert response to a list of NominatimResponse objects
      return (response as List<dynamic>)
          .map<NominatimResponse>(
              (i) => NominatimResponse.fromJson(i as Map<String, dynamic>))
          .toList();
    });
  }
}
