import 'model/request/request.dart';
import 'model/response/reverse_response.dart';
import 'service/nominatim_service.dart';

/// A utility class for interacting with the Nominatim service to perform reverse geocoding and search operations.
class NominatimFlutter {
  // Create a private instance of NominatimFlutter class using the Singleton pattern.
  static final _instance = NominatimFlutter._();

  // Public getter to access the singleton instance.
  static NominatimFlutter get instance => _instance;

  // Private constructor to ensure that instances can only be created internally.
  NominatimFlutter._();

  // Create an instance of the NominatimService implementation.
  final _nominatimService = NominatimServiceImpl();

  /// Performs a reverse geocoding request to obtain address information for a given latitude and longitude.
  ///
  /// [reverseRequest]: A [ReverseRequest] object containing the latitude and longitude to perform the reverse geocoding.
  Future<NominatimResponse> reverse(
      {required ReverseRequest reverseRequest}) async {
    // Delegates the reverse geocoding request to the NominatimService implementation.
    return await _nominatimService.reverse(reverseRequest: reverseRequest);
  }

  /// Performs a search request to find places matching the provided search criteria.
  ///
  /// [searchRequest]: A [SearchRequest] object containing the search criteria such as query, location, and filters.
  Future<List<NominatimResponse>> search(
      {required SearchRequest searchRequest}) async {
    // Delegates the search request to the NominatimService implementation.
    return await _nominatimService.search(searchRequest: searchRequest);
  }
}
