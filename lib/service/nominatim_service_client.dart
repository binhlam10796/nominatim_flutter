import '../config/nominatim_configuration.dart';
import '../model/request/request.dart';
import '../network/api_provider.dart';

/// Enum to represent the type of Nominatim service.
enum NominatimServiceType {
  /// Search service type.
  search,

  /// Reverse geocoding service type.
  reverse,

  /// Status service type.
  status,

  /// Lookup service type.
  lookup
}

/// Class responsible for making requests to the Nominatim service.
class NominatimServiceClient implements APIRequestRepresentable {
  /// The type of Nominatim service.
  final NominatimServiceType type;

  /// The search request parameters, applicable if the service type is [NominatimServiceType.search].
  final SearchRequest? searchRequest;

  /// The reverse request parameters, applicable if the service type is [NominatimServiceType.reverse].
  final ReverseRequest? reverseRequest;

  /// The lookup request parameters, applicable if the service type is [NominatimServiceType.lookup].
  final LookupRequest? lookupRequest;

  /// The language for the request, if applicable.
  final String? language;

  /// Constructor for the [NominatimServiceClient].
  ///
  /// [type] is required and specifies the type of Nominatim service.
  /// [searchRequest] is optional and used if the service type is [NominatimServiceType.search].
  /// [reverseRequest] is optional and used if the service type is [NominatimServiceType.reverse].
  /// [lookupRequest] is optional and used if the service type is [NominatimServiceType.lookup].
  /// [language] is optional and specifies the language for the request.
  NominatimServiceClient({
    required this.type,
    this.searchRequest,
    this.reverseRequest,
    this.lookupRequest,
    this.language,
  });

  /// Get the request body. Always returns null as the Nominatim service does not require a request body.
  @override
  get bodies => null;

  /// Base URL for the Nominatim service.
  @override
  String get endpoints =>
      NominatimConfiguration.baseUrl ?? "https://nominatim.openstreetmap.org";

  /// Headers for the request. Always accepts any content type.
  @override
  Map<String, String>? get headers {
    return {
      "accept": "*/*",
      if (NominatimConfiguration.userAgent != null)
        "User-Agent": NominatimConfiguration.userAgent ?? '',
    };
  }

  /// HTTP method for the request. Always uses GET method.
  @override
  HTTPMethod get methods => HTTPMethod.get;

  /// Get the API endpoint path based on the service type.
  ///
  /// Returns "/search" for [NominatimServiceType.search],
  /// "/reverse" for [NominatimServiceType.reverse], and
  /// "/status" for [NominatimServiceType.status] and
  /// "/lookup" for [NominatimServiceType.lookup].
  @override
  String get paths {
    switch (type) {
      case NominatimServiceType.search:
        return "/search";
      case NominatimServiceType.reverse:
        return "/reverse";
      case NominatimServiceType.status:
        return "/status";
      case NominatimServiceType.lookup:
        return "/lookup";
    }
  }

  /// Get the query parameters for the request based on the service type.
  ///
  /// For [NominatimServiceType.search], returns a map of search parameters.
  /// For [NominatimServiceType.reverse], returns a map of reverse geocoding parameters.
  /// For [NominatimServiceType.status], returns a map with the format parameter.
  /// For [NominatimServiceType.lookup], returns a map of lookup parameters.
  @override
  Map<String, String>? get queries {
    switch (type) {
      case NominatimServiceType.search:
        assert(searchRequest != null);
        return {
          "format": "jsonv2",
          'q': searchRequest!.query,
          'limit': "${searchRequest?.limit ?? 10}",
          if (searchRequest?.street != null) 'street': searchRequest!.street!,
          if (searchRequest?.city != null) 'city': searchRequest!.city!,
          if (searchRequest?.county != null) 'county': searchRequest!.county!,
          if (searchRequest?.state != null) 'state': searchRequest!.state!,
          if (searchRequest?.country != null)
            'country': searchRequest!.country!,
          if (searchRequest?.postalCode != null)
            'postalcode': searchRequest!.postalCode!,
          "addressdetails":
              "${(searchRequest?.addressDetails ?? true) ? 1 : 0}",
          "extratags": "${(searchRequest?.extraTags ?? true) ? 1 : 0}",
          "namedetails": "${(searchRequest?.nameDetails ?? true) ? 1 : 0}",
          if (searchRequest?.language != null)
            'accept-language': searchRequest!.language!,
          if (searchRequest?.countryCodes != null &&
              searchRequest!.countryCodes!.isNotEmpty)
            'countrycodes': searchRequest!.countryCodes!.join(','),
          if (searchRequest?.excludePlaceIds != null &&
              searchRequest!.excludePlaceIds!.isNotEmpty)
            'exclude_place_ids': searchRequest!.excludePlaceIds!.join(','),
          if (searchRequest?.viewBox != null)
            'viewbox':
                '${searchRequest!.viewBox!.westLongitude},${searchRequest!.viewBox!.southLatitude},${searchRequest!.viewBox!.eastLongitude},${searchRequest!.viewBox!.northLatitude}',
          if (searchRequest?.viewBox != null) 'bounded': '1',
          if (language != null) 'accept-language': language!,
        };
      case NominatimServiceType.reverse:
        assert(reverseRequest != null);
        return {
          "format": "jsonv2",
          "lat": "${reverseRequest?.lat}",
          "lon": "${reverseRequest?.lon}",
          "addressdetails":
              "${(reverseRequest?.addressDetails ?? true) ? 1 : 0}",
          "extratags": "${(reverseRequest?.extraTags ?? true) ? 1 : 0}",
          "namedetails": "${(reverseRequest?.nameDetails ?? true) ? 1 : 0}",
          if (language != null) 'accept-language': language!,
        };
      case NominatimServiceType.status:
        return {
          "format": "json",
        };
      case NominatimServiceType.lookup:
        assert(lookupRequest != null);
        return {
          "format": "jsonv2",
          "osm_ids": lookupRequest?.osmIds ?? '',
          "addressdetails":
              "${(lookupRequest?.addressDetails ?? true) ? 1 : 0}",
          "extratags": "${(lookupRequest?.extraTags ?? true) ? 1 : 0}",
          "namedetails": "${(lookupRequest?.nameDetails ?? true) ? 1 : 0}",
          "polygon_geojson":
              "${(lookupRequest?.polygonGeojson ?? true) ? 1 : 0}",
          if (language != null) 'accept-language': language!,
        };
    }
  }

  /// Perform the request using the [APIProvider].
  ///
  /// Returns a [Future] that completes with the response from the API.
  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  /// Get the complete URL for the request.
  ///
  /// Combines the base URL and the endpoint path.
  @override
  String get urls => endpoints + paths;
}
