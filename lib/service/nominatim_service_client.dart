import '../model/request/request.dart';
import '../network/api_provider.dart';

// Enum to represent the type of Nominatim service
enum NominatimServiceType { search, reverse }

// Class responsible for making requests to the Nominatim service
class NominatimServiceClient implements APIRequestRepresentable {
  final NominatimServiceType type;
  final SearchRequest? searchRequest;
  final ReverseRequest? reverseRequest;
  final String? language;

  // Constructor for the NominatimServiceClient
  NominatimServiceClient({
    required this.type,
    this.searchRequest,
    this.reverseRequest,
    this.language,
  });

  // Get the request body (null in this case)
  @override
  get bodies => null;

  // Base URL for the Nominatim service
  @override
  String get endpoints => "https://nominatim.openstreetmap.org";

  // Headers for the request
  @override
  Map<String, String>? get headers => {"accept": "*/*"};

  // HTTP method for the request
  @override
  HTTPMethod get methods => HTTPMethod.get;

  // Get the API endpoint path based on the service type
  @override
  String get paths {
    switch (type) {
      case NominatimServiceType.search:
        return "/search";
      case NominatimServiceType.reverse:
        return "/reverse";
    }
  }

  // Get the query parameters for the request
  @override
  Map<String, String>? get queries {
    switch (type) {
      case NominatimServiceType.search:
        // Assert that searchRequest is not null
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
        // Assert that reverseRequest is not null
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
    }
  }

  // Perform the request using the APIProvider
  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  // Get the complete URL for the request
  @override
  String get urls => endpoints + paths;
}
