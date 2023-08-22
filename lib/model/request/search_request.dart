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

/// View box for searching
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
