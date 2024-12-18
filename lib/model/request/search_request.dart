/// A model class representing a search request with various parameters to filter and refine the search results.
///
/// This class is used to encapsulate the parameters required for making
/// a search request to find places based on a query and optional structured search parameters.
///
/// The [SearchRequest] class includes options to specify the maximum number of results,
/// preferred language, geographical constraints, and additional details to be included in the response.
///
/// Example usage:
/// ```dart
/// SearchRequest request = SearchRequest(
///   limit: 10,
///   query: 'coffee shop',
///   city: 'San Francisco',
///   state: 'CA',
///   country: 'USA',
///   addressDetails: true,
///   extraTags: true,
///   nameDetails: true,
/// );
/// ```
///
/// Properties:
/// - [limit]: The maximum number of search results to be returned. This is a required parameter.
/// - [query]: The search query used to find places. This is a required parameter.
/// - [street]: Optional street name for structured search.
/// - [city]: Optional city name for structured search.
/// - [county]: Optional county name for structured search.
/// - [state]: Optional state name for structured search.
/// - [country]: Optional country name for structured search.
/// - [postalCode]: Optional postal code for structured search.
/// - [language]: Optional preferred language for showing search results.
/// - [countryCodes]: Optional list of country codes to limit search results.
/// - [excludePlaceIds]: Optional list of place IDs to exclude from search results.
/// - [viewBox]: Optional view box to search within a geographical area.
/// - [addressDetails]: Specifies whether to include detailed address information in the response. Defaults to `false`.
/// - [extraTags]: Specifies whether to include extra tags like Wikipedia link, opening hours, etc. Defaults to `false`.
/// - [nameDetails]: Specifies whether to include a list of alternative names in the results. Defaults to `false`.
///
/// Constructor:
/// - [SearchRequest]: Creates a new instance of the [SearchRequest] class with the specified parameters.
class SearchRequest {
  /// The maximum number of search results to be returned.
  final int limit;

  /// The search query used to find places.
  final String query;

  /// Optional: Street name for structured search.
  final String? street;

  /// Optional: City name for structured search.
  final String? city;

  /// Optional: County name for structured search.
  final String? county;

  /// Optional: State name for structured search.
  final String? state;

  /// Optional: Country name for structured search.
  final String? country;

  /// Optional: Postal code for structured search.
  final String? postalCode;

  /// Optional: Preferred language for showing search results.
  final String? language;

  /// Optional: Limit search results to specific country codes.
  final List<String>? countryCodes;

  /// Optional: Skip certain place IDs from appearing in search results.
  final List<String>? excludePlaceIds;

  /// Optional: Specify a view box for searching within a geographical area.
  final ViewBox? viewBox;

  /// Specifies whether to include detailed address information in the response.
  bool? addressDetails;

  /// Specifies whether to include extra tags like Wikipedia link, opening hours, etc.
  bool? extraTags;

  /// Specifies whether to include a list of alternative names in the results.
  bool? nameDetails;

  SearchRequest({
    required this.limit,
    required this.query,
    this.street,
    this.city,
    this.county,
    this.state,
    this.country,
    this.postalCode,
    this.language,
    this.countryCodes,
    this.excludePlaceIds,
    this.viewBox,
    this.addressDetails = true,
    this.extraTags = true,
    this.nameDetails = true,
  });
}

/// A model class representing a geographical view box for searching within a specific area.
///
/// This class is used to define the geographical boundaries for a search request,
/// allowing the search to be constrained within a specified rectangular area.
///
/// The [ViewBox] class ensures that the provided latitude and longitude values
/// are within valid ranges and that the north boundary is greater than the south boundary,
/// and the east boundary is greater than the west boundary.
///
/// Example usage:
/// ```dart
/// ViewBox viewBox = ViewBox(
///   northLatitude: 37.7749,
///   southLatitude: 37.7049,
///   eastLongitude: -122.4194,
///   westLongitude: -122.5194,
/// );
/// ```
///
/// Properties:
/// - [northLatitude]: North boundary of the view box. Must be greater than [southLatitude] and less than or equal to 90.
/// - [southLatitude]: South boundary of the view box. Must be less than [northLatitude] and greater than or equal to -90.
/// - [eastLongitude]: East boundary of the view box. Must be greater than [westLongitude] and less than or equal to 180.
/// - [westLongitude]: West boundary of the view box. Must be less than [eastLongitude] and greater than or equal to -180.
///
/// Constructor:
/// - [ViewBox]: Creates a new instance of the [ViewBox] class with the specified boundaries.
class ViewBox {
  /// North boundary of the view box
  final double northLatitude;

  /// South boundary of the view box
  final double southLatitude;

  /// East boundary of the view box
  final double eastLongitude;

  /// West boundary of the view box
  final double westLongitude;

  ViewBox(
    this.northLatitude,
    this.southLatitude,
    this.eastLongitude,
    this.westLongitude,
  )   : assert(
          northLatitude > southLatitude,
          'north latitude has to be greater than south latitude',
        ),
        assert(
          eastLongitude > westLongitude,
          'east longitude has to be greater than west longitude',
        ),
        assert(
          northLatitude <= 90,
          'north latitude must be smaller than or equals 90',
        ),
        assert(
          southLatitude >= -90,
          'south latitude must be greater than or equals -90',
        ),
        assert(
          eastLongitude <= 180,
          'east longitude must be smaller than or equals 180',
        ),
        assert(
          westLongitude >= -180,
          'east longitude must be greater than or equals -180',
        );
}
